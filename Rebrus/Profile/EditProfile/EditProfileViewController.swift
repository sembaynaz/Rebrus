//
//  EditProfileViewController.swift
//  Rebrus
//
//

import UIKit
import Alamofire
import SwiftyJSON
class EditProfileViewController: UIViewController {
    
    var user: User
    var userImage: UIImage? {
        didSet {
            // Code to execute when userImage is set
            guard let image = userImage else {
                print("userImage is set to nil")
                return
            }
            headerView.setContent(image: image)
        
        }
    }
    
    private let headerView = EditProfileHeaderView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserDataTableViewCell.self, forCellReuseIdentifier: UserDataTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let changeButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Изменить профиль".localized(from: .auth), for: .normal)
        return button
    }()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль".localized(from: .main)
        setupUI()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        headerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
}
extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserDataTableViewCell.identifier, for: indexPath) as! UserDataTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        switch indexPath.row {
        case 0:
            cell.setContent(text: user.lastName, placeHolder: "Иванов", title: "Фамилия")
        case 1:
            cell.setContent(text: user.firstName, placeHolder: "Иван", title: "Имя")
        case 2:
            cell.setContent(text: user.middleName, placeHolder: "Иванович", title: "Отчество")
        default:
            print()
        }
        
        
        return cell
    }
}
extension EditProfileViewController: SomethingTappedDelegate {
    func somethingTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
}

extension EditProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImage = image
        } else {
            print("Error picking image")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: SendValueDelegate {
    func valueChanged(in cell: UITableViewCell, value: String) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        switch indexPath.row {
        case 0:
            user.lastName = value
        case 1:
            user.firstName = value
        case 2:
            user.middleName = value
        default:
            print()
        }
        
    }
    
    private func sendPhoto(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "image", fileName: "photo.jpg", mimeType: "image/jpeg")
        }, to: Configuration.UPLOAD_PHOTO, headers: headers)
        .response { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let data):
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    sendUserData(with: responseString)
                    print("Upload Successful: \(responseString)")
                } else {
                    print("Upload Successful but failed to convert response to string")
                }
            case .failure(let error):
                print("Upload Error: \(error)")
            }
        }
    }
    
    
    @objc private func changeButtonTapped() {
        if let image = userImage {
            sendPhoto(image: image)
        } else {
            sendUserData(with: nil)
        }
        
    }
    
    private func sendUserData(with photoURL: String?) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        var parameters: [String: Any] = [:]
        
        if let firstName = user.firstName { parameters["firstName"] = firstName }
        if let lastName = user.lastName { parameters["lastName"] = lastName }
        if let middleName = user.middleName { parameters["middleName"] = middleName }
        if let userPhotoURL = photoURL { parameters["avatarUrl"] = userPhotoURL }
        
        print(parameters)
        
        if !parameters.isEmpty {
            AF.request(Configuration.UPDATE_USER_INFO, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
                .responseData { response in
                    let json = JSON(response.data!)
                    print(json)
                    switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                            
                            if let navigationController = self.navigationController {
                                navigationController.popToRootViewController(animated: true)
                            }
                            print("success")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                    
                }
        }
    }
}

extension EditProfileViewController {
    private func setupUI() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
        }
        view.addSubview(changeButton)
        
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        
        changeButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(33)
            make.height.equalTo(52)
            make.bottom.equalTo(view.snp.bottom).offset(-150)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(changeButton.snp.top)
        }
    }
}
