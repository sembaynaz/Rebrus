//
//  ProfileViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 15/01/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 28)
        label.text = "Профиль"
        label.textColor = ColorManager.black
        return label
    }()
    private let headerView = ProfileHeaderView()
    
    private let titles = ["Об аккаунте", "Настройка", "Выйти из аккаунта"]
    private let subtitles = ["Изменить информацию об аккаунте", "Удаление или деактивация аккаунта", ""]
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.text = "Общие"
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
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
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.selectionStyle = .none
        cell.setContent(icon: "profileIcon\(indexPath.row+1)", title: titles[indexPath.row], subtitle: subtitles[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let settingsVC = SettingsViewController()
            navigationController?.pushViewController(settingsVC, animated: true)
        default:
            print("invalid cell")
        }
    }
}
