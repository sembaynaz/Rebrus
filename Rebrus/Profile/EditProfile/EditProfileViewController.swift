//
//  EditProfileViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 25/03/2024.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private let headerView = EditProfileHeaderView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserDataTableViewCell.self, forCellReuseIdentifier: UserDataTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Профиль"
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
        //cell.setContent()
        
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
            headerView.setContent(image: image)
        } else {
            print("Error picking image")
        }
        
        picker.dismiss(animated: true, completion: nil)
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview()
        }
    }
}
