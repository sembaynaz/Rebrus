//
//  DeleteAccountViewController.swift
//  Rebrus
//
//

import UIKit

class DeleteAccountViewController: UIViewController {
    
    private let reasons = ["Нехватка времени".localized(from: .main), "Неудобно".localized(from: .main), "Сложности при использовании".localized(from: .main), "Мало возможностей".localized(from: .main), "Другое".localized(from: .main)]
    
    private var selectedIndex: Int?
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Причина удаления".localized(from: .main)
        label.font = UIFont(name: "Montserrat-Medium", size: 24)
        label.textColor = ColorManager.black
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 15
        tableView.layer.masksToBounds = true
        tableView.separatorStyle = .none
        tableView.register(DeleteAccountTableViewCell.self, forCellReuseIdentifier: DeleteAccountTableViewCell.identifier)
        return tableView
    }()
    
    private let deleteButton: ActivatedButton = {
        let button = ActivatedButton()
        button.setTitle("Удалить аккаунт".localized(from: .main), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Удалить аккаунт".localized(from: .main)
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(33)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(33)
            make.height.equalTo(250)
        }
        
        view.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview().inset(33)
            make.bottom.equalToSuperview().inset(150)
        }
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func deleteButtonTapped() {
        let vc = DeleteHalfScreenViewController()
        present(vc, animated: true)
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension DeleteAccountViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DeleteAccountTableViewCell.identifier, for: indexPath) as! DeleteAccountTableViewCell
        cell.selectionStyle = .none
        cell.setContent(with: reasons[indexPath.row])
        cell.setSelected(isSelected: selectedIndex == indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = (selectedIndex == indexPath.row) ? nil : indexPath.row
        deleteButton.setActive(selectedIndex == indexPath.row)
        tableView.reloadData()
    }
}
