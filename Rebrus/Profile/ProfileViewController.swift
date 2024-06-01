//
//  ProfileViewController.swift
//  Rebrus
//
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
    private var user = User()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 28)
        label.textColor = ColorManager.black
        return label
    }()
    private let headerView = ProfileHeaderView()
    
    private var dataSource: [ProfileData] = []
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = ColorManager.black
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        setStrings()
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserData()
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        NotificationCenter.default.addObserver(self, selector: #selector(setStrings), name: Notification.Name("localize"), object: nil)
    }
    
    private func getUserData() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)"
        ]
        
        AF.request(Configuration.USER_INFO, method: .get,  encoding: URLEncoding.default, headers: headers)
                    .responseData { response in
                    var resultString = ""
                        
                    if let data = response.data {
                        resultString = String(data: data, encoding: .utf8)!
                    }
                        print(response.data)
                    switch response.result {
                    case .success:
                        if response.response?.statusCode == 200 || response.response?.statusCode == 201 || response.response?.statusCode == 202 {
                            print("success")
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            
        

        
//        AF.request(Configuration.USER_INFO, method: .get, headers: headers).responseDecodable(of: User.self) { [weak self] response in
//            guard let self = self else { return }
//            switch response.result {
//            case .success(let value):
//                self.user = value
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }
    
    @objc private func setStrings() {
        titleLabel.text = "Профиль".localized(from: .main)
        label.text = "Общие".localized(from: .main)
        dataSource = [ProfileData(title: "Профиль".localized(from: .main), subtitle: "Изменить профиль".localized(from: .main)), ProfileData(title: "Настройка".localized(from: .main), subtitle: "Удаление или деактивация аккаунта".localized(from: .main)), ProfileData(title: "Выйти из аккаунта".localized(from: .main), subtitle: "")]
        tableView.reloadData()
        headerView.setContent(fullName: nil)
    }
    
    private func setupUI() {
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 38
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(tableView)
        
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(headerView)
        mainStack.addArrangedSubview(stack)
        
        view.addSubview(mainStack)
        
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.leading.trailing.equalToSuperview().inset(27)
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.selectionStyle = .none
        cell.setContent(icon: "profileIcon\(indexPath.row+1)", title: dataSource[indexPath.row].title, subtitle: dataSource[indexPath.row].subtitle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let editVC = EditProfileViewController()
            navigationController?.pushViewController(editVC, animated: true)
        case 1:
            let settingsVC = SettingsViewController()
            navigationController?.pushViewController(settingsVC, animated: true)
        default:
            let vc = AlertViewController()
            vc.modalPresentationStyle = .overFullScreen
            vc.activeButtonTitle = "Да".localized(from: .auth)
            vc.imageName = "logout"
            vc.cancelButtonTitle = "Нет".localized(from: .auth)
            vc.messageText = "Хотите выйти из аккаунта?".localized(from: .auth)
            vc.isSecondDelegate = true
            present(vc, animated: false)
            vc.secondDelegate = self
        }
    }
}


extension ProfileViewController: AlertSecondDelegate {
    func didAgreeButtonTappedSecond() {
        view.unblurContainView()
        
        UserDefaults.standard.removeObject(forKey: "accessToken")
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let launchController = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateInitialViewController()
        launchController?.modalPresentationStyle = .fullScreen
        self.present(launchController!, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            launchController!.dismiss(animated: false) {
                let rootViewController = UINavigationController(rootViewController: OnboardingViewController())
                window.rootViewController?.dismiss(animated: false, completion: nil)
                window.rootViewController = nil
                window.rootViewController = rootViewController
                window.makeKeyAndVisible()
            }
        }
    }
}
