//
//  SettingsViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 18/01/2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let dataSource = [ProfileData(title: "Язык", subtitle: "Сменить язык"), ProfileData(title: "Пароль", subtitle: "Сброс пароля"), ProfileData(title: "Условие и политика", subtitle: "Ознакомление с условием и политика продукта"), ProfileData(title: "Удалить аккаунт", subtitle: "Выключение или деактивация аккаунта")]
    
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
        title = "Настройка"
        setupUI()
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(27)
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
        cell.selectionStyle = .none
        cell.setContent(icon: "settingsIcon\(indexPath.row+1)", title: dataSource[indexPath.row].title, subtitle: dataSource[indexPath.row].subtitle)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let languageVC = LanguageViewController()
            navigationController?.pushViewController(languageVC, animated: true)
        case 1:
            let changeVC = ChangePasswordViewController()
            changeVC.isChangePassword = true
            navigationController?.pushViewController(changeVC, animated: true)
        case 2:
            let conditionsVC = ConditionsViewController()
            navigationController?.pushViewController(conditionsVC, animated: true)
        case 3:
            let deleteAccountVC = DeleteAccountViewController()
            navigationController?.pushViewController(deleteAccountVC, animated: true)
        default:
            print("invalid cell")
        }
    }
}
