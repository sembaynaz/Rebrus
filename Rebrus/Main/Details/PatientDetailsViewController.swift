//
//  PatientDetailsViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 08/05/2024.
//

import UIKit

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
        title = "Пациент"
        setupUI()
        generateBlockOfInfo()
        userNameLabel.text = patient.fullName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.prefersLargeTitles = false

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
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        let infoBlock = generateBlockOfInfo()
        view.addSubview(infoBlock)
        infoBlock.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(35)
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
    }
    
    private func generateBlockOfInfo() -> UIStackView{
        let totalItems = viewModel.numberOfItems()

        let parentStack = UIStackView()
        parentStack.axis = .vertical
        parentStack.spacing = 35 
        
        for i in stride(from: 0, to: totalItems - 5, by: 3) {
            let groupStack = UIStackView()
            groupStack.axis = .horizontal
            groupStack.spacing = 10 
            
            for j in i..<min(i + 3, totalItems) {
                let stack = makeStack(data: viewModel.item(at: j))
                groupStack.addArrangedSubview(stack)
            }
            
            parentStack.addArrangedSubview(groupStack)
        }
        return parentStack
    }
    
    private func generateLevelBlock() -> UIView {
        let level = viewModel.getDementiaLevel(by: patient.level)
        let blockView = UIView()
        blockView.backgroundColor = ColorManager.blue
        blockView.layer.cornerRadius = 5
        
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 15)
        label.textColor = .white
        label.text = "Стадия деменции"
        
        let levelLabel = UILabel()
        levelLabel.font = UIFont(name: "Montserrat-Regular", size: 15)
        levelLabel.textColor = .white
        levelLabel.text = level?.title
        
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
            infoLabel.text = patient.dob
        case .address:
            infoLabel.text = patient.address
        case .region:
            infoLabel.text = patient.region
        case .phoneNumber:
            infoLabel.text = patient.phoneNumber
        case .date:
            infoLabel.text = patient.date
        case .doctor:
            infoLabel.text = patient.doctorName
        default:
            return UIStackView()
        }
        
        let cellTypeLabel = UILabel()
        cellTypeLabel.textColor = ColorManager.greyTextColor
        cellTypeLabel.font = UIFont(name: "Montserrat-SemiBold", size: 12)
        cellTypeLabel.text = data.title
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.addArrangedSubview(cellTypeLabel)
        stack.addArrangedSubview(infoLabel)
        return stack
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension PatientDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PatientResultCollectionViewCell.identifier, for: indexPath) as! PatientResultCollectionViewCell
        
        cell.setText(for: viewModel.item(at: indexPath.row + 7), with: patient)
        cell.setLastCell(isLast: indexPath.row == 4)
        return cell
    }
    
    
}
extension PatientDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 50)
    }
}

