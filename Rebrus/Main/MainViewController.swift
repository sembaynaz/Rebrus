//
//  MainViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 18/01/2024.
//

import UIKit

class MainViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 28)
        label.text = "Недавние пациенты"
        label.textColor = ColorManager.black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PatientPreviewTableViewCell.self, forCellReuseIdentifier: PatientPreviewTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.tableHeaderView = UIView()
        tableView.separatorColor = ColorManager.borderColor
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(81)
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.bottom.equalToSuperview().inset(32)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PatientPreviewTableViewCell.identifier, for: indexPath) as! PatientPreviewTableViewCell
        cell.selectionStyle = .none
        //cell.setContent()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = PatientDetailsViewController(with: Patient(fullName: "Кожабеков Улан Даулетулы", moca: 21.4, mmse: 21.4, hads: 21.4, hars: 21.4, miniCog: 321.4, gender: "Женский", dob: "2002.14.12", phoneNumber: "(777) 777-7777", address: "улица Пушкина, 14", region: "г. Алматы", date: "24/02/2024", doctorName: "Андреев Андрей Андреевич", level: 1))
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
