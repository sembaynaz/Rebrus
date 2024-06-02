//
//  SettingsViewController.swift
//  Rebrus
//
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var dataSource: [ProfileData] = []
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        NotificationCenter.default.addObserver(self, selector: #selector(setStrings), name: Notification.Name("localize"), object: nil)
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.trailing.equalToSuperview().inset(27)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func setStrings() {
        title = "Настройка".localized(from: .main)
        dataSource = [ProfileData(title: "Язык".localized(from: .main), subtitle: "Сменить язык".localized(from: .main)), ProfileData(title: "Пароль".localized(from: .main), subtitle: "Сброс пароля".localized(from: .main)), ProfileData(title: "Условие и политика".localized(from: .main), subtitle: "Ознакомление с условием и политика продукта".localized(from: .main)), ProfileData(title: "Удалить аккаунт".localized(from: .main), subtitle: "Выключение или деактивация аккаунта".localized(from: .main))]
        tableView.reloadData()
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
            let changeVC = ChangePasswordViewController(token: UserDefaults.standard.string(forKey: "accessToken") ?? "")
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
