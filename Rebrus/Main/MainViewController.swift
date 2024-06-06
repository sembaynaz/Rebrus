//
//  MainViewController.swift
//  Rebrus
//
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    private var patients: [Patient] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 28)
        label.text = "Недавние пациенты".localized(from: .main)
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
        NotificationCenter.default.addObserver(self, selector: #selector(setStrings), name: Notification.Name("localize"), object: nil)
        
        let group = DispatchGroup()
        group.enter()
        getPatients(group: group)
        group.notify(queue: .main) {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.setupUI()
        }
    }
    
    @objc private func setStrings() {
        titleLabel.text = "Недавние пациенты".localized(from: .main)
        tableView.reloadData()
    }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PatientPreviewTableViewCell.identifier, for: indexPath) as! PatientPreviewTableViewCell
        cell.selectionStyle = .none
        cell.setContent(patient: patients[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        let nextVC = PatientDetailsViewController(with: patients[indexPath.row])
        //        Patient(firstName: "Кожабеков Улан Даулетулы", moca: 21.4, mmse: 21.4, hads: 21.4, hars: 21.4, miniCog: 321.4, gender: "Женский", dob: "2002.14.12", phoneNumber: "(777) 777-7777", address: "улица Пушкина, 14", region: "г. Алматы", date: "24/02/2024", doctorName: "Андреев Андрей Андреевич", level: 1)
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
//MARK: - function to get list of patients
extension MainViewController {
    private func getPatients(group: DispatchGroup) {
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)",
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
        
        let parameters: [String: Any] = ["pageNumber": 0, "pageSize": 5]
        
        AF.request(Configuration.GET_PATIENTS, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .responseData { response in
                print(response.response?.statusCode ?? "No status code")
                
                switch response.result {
                case .success(let data):
                    print(data)
                    do {
                        let decoder = JSONDecoder()
                        let patientsResponse = try decoder.decode(PatientsResponse.self, from: data)
                        self.patients = patientsResponse.content
                        self.tableView.reloadData()
                        print(self.patients)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                    print("success")
                case .failure(let error):
                    print("Upload Error: \(error)")
                }
                group.leave()
            }
    }
    
}
