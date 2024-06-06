//
//  PatientDetailsViewController.swift
//  Rebrus
//
//

import UIKit
import Alamofire

class PatientDetailsViewController: UIViewController {
    
    private let viewModel = PatientDataViewModel()
    
    private var patient: Patient
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.allowsMultipleSelection = false
        
        collection.showsHorizontalScrollIndicator = false
        collection.register(PatientResultCollectionViewCell.self, forCellWithReuseIdentifier: PatientResultCollectionViewCell.identifier)
        return collection
    }()
    
    private let noteTextView: UITextView = {
        let textView = UITextView()
        textView.textContainerInset = UIEdgeInsets(top: 30, left: 30, bottom: 15, right: 30)
        textView.layer.cornerRadius = 5
        textView.textColor = ColorManager.subtitleTextColor
        textView.font = UIFont(name: "Montserrat-Regular", size: 16)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.isScrollEnabled = true
        textView.backgroundColor = ColorManager.lightGrey
        
        return textView
    }()
    
    private let saveNoteButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorManager.blue
        if let originalImage = UIImage(systemName: "square.and.pencil") {
            let resizedImage = originalImage.resize(to: CGSize(width: 27, height: 27))
            button.setImage(resizedImage.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        return button
    }()
    
    required init(with patient: Patient) {
        self.patient = patient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        title = "Пациент".localized(from: .main)
        setupUI()
        generateBlockOfInfo()
        
        //noteTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false
        
        userNameLabel.text = [patient.lastName, patient.firstName, patient.middleName].compactMap { $0 }.joined(separator: " ")
        
        textViewEnable(isEnabled: patient.note.value == nil)
        noteTextView.text = patient.note.value
    }
    
    private func setupUI() {
        view.addSubview(userNameLabel)
        view.addSubview(collectionView)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.trailing.equalToSuperview().inset(33)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(patient.assessments.count == 0 ? 0 : 50)
        }
        let infoBlock = generateBlockOfInfo()
        view.addSubview(infoBlock)
        infoBlock.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(patient.assessments.count == 0 ? 0 : 35)
            make.leading.trailing.equalToSuperview().inset(33)
        }
        
        let line = UIView()
        line.backgroundColor = ColorManager.collectionSeparatorColor
        view.addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(infoBlock.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(33)
            make.height.equalTo(1)
        }
        
        let levelBlock = generateLevelBlock()
        view.addSubview(levelBlock)
        levelBlock.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(33)
        }
        
        view.addSubview(noteTextView)
        noteTextView.snp.makeConstraints { make in
            make.top.equalTo(levelBlock.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(33)
            make.height.equalTo(200)
        }
        view.addSubview(saveNoteButton)
        saveNoteButton.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.top.trailing.equalTo(noteTextView).inset(5)
        }
        saveNoteButton.addTarget(self, action: #selector(saveNoteTapped), for: .touchUpInside)
    }
    
    private func generateBlockOfInfo() -> UIStackView{
        let totalItems = viewModel.numberOfItems()
        
        let parentStack = UIStackView()
        parentStack.axis = .vertical
        parentStack.spacing = 35
        
        for i in stride(from: 0, to: totalItems, by: 3) {
            let groupStack = UIStackView()
            groupStack.axis = .horizontal
            groupStack.distribution = .equalSpacing
            
            for j in i..<min(i + 3, totalItems) {
                let stack = makeStack(data: viewModel.item(at: j))
                groupStack.addArrangedSubview(stack)
            }
            
            parentStack.addArrangedSubview(groupStack)
        }
        return parentStack
    }
    
    private func generateLevelBlock() -> UIView {
        let level = viewModel.getDementiaLevel(by: patient.stageOfDementia)
        let blockView = UIView()
        blockView.backgroundColor = ColorManager.blue
        blockView.layer.cornerRadius = 5
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = .white
        label.text = "Стадия деменции".localized(from: .main)
        
        let levelLabel = UILabel()
        levelLabel.font = UIFont(name: "Montserrat-Regular", size: 15)
        levelLabel.textColor = .white
        levelLabel.text = level?.title.localized(from: .main)
        
        let stack = UIStackView()
        stack.spacing = 11
        stack.axis = .vertical
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(levelLabel)
        
        blockView.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.equalToSuperview().inset(34)
        }
        
        let emojiLabel = UILabel()
        emojiLabel.font = UIFont.systemFont(ofSize: 32)
        emojiLabel.text = level?.emoji
        
        blockView.addSubview(emojiLabel)
        emojiLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(34)
            make.bottom.equalToSuperview().inset(14)
        }
        
        return blockView
    }
    
    private func makeStack(data: PatientCellData) -> UIStackView {
        let infoLabel = UILabel()
        infoLabel.textColor = .black
        infoLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        
        switch data.cellType {
        case .gender:
            infoLabel.text = patient.gender
        case .dob:
            infoLabel.text = patient.birthDate
        case .address:
            infoLabel.text = patient.address
        case .region:
            infoLabel.text = patient.region
        case .phoneNumber:
            infoLabel.text = patient.phone
        case .doctor:
            infoLabel.text = patient.responsible
        case .date:
            infoLabel.text = patient.appointments[0].date
        default:
            return UIStackView()
        }
        
        let cellTypeLabel = UILabel()
        cellTypeLabel.textColor = ColorManager.greyTextColor
        cellTypeLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        cellTypeLabel.text = data.title.localized(from: .main)
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.addArrangedSubview(cellTypeLabel)
        stack.addArrangedSubview(infoLabel)
        return stack
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PatientDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return patient.assessments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PatientResultCollectionViewCell.identifier, for: indexPath) as! PatientResultCollectionViewCell
        
        cell.setText(for: patient.assessments[indexPath.row])
        cell.setLastCell(isLast: indexPath.row == 4)
        return cell
    }
    
    
}
extension PatientDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 50)
    }
}

extension PatientDetailsViewController {
    @objc private func saveNoteTapped() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Storage.sharedInstance.accessToken)",
            "Content-Type": "application/json"
        ]
        
        print(noteTextView.text)
        
        let parameters: [String: Any] = ["value": noteTextView.text ?? ""]
        
        let url = Configuration.PATIENT_DETAILS + "/\(patient.id)/note"
        AF.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseData { response in
                print(response.response?.statusCode ?? "No status code")
                
                switch response.result {
                case .success(_):
                    print("success")
                case .failure(let error):
                    print("Upload Error: \(error)")
                }
            }
    }
}
extension PatientDetailsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let textIsEmpty = textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        textViewEnable(isEnabled: textIsEmpty)
    }
    
    private func textViewEnable(isEnabled: Bool) {
//        saveNoteButton.tintColor = isEnabled ? .gray : ColorManager.blue
//        saveNoteButton.isEnabled = !isEnabled
    }
}
