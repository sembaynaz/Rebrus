//
//  PatientResultCollectionViewCell.swift
//  Rebrus
//
//

import UIKit

class PatientResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "PatientResultCollectionViewCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorManager.blueTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Inter-Regular", size: 16)
        label.text = "MoCA"
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        label.text = "21.4"
        return label
    }()
    
    private let lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = ColorManager.collectionSeparatorColor
        return lineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("error")
    }
    
    func setText(for cellData: PatientCellData, with data: Patient) {
        switch cellData.cellType {
        case .moca:
            resultLabel.text = "\(data.moca)"
        case .mmse:
            resultLabel.text = "\(data.mmse)"
        case .hads:
            resultLabel.text = "\(data.hads)"
        case .hars:
            resultLabel.text = "\(data.hars)"
        case .miniCog:
            resultLabel.text = "\(data.miniCog)"
        default:
            return
        }
        
        categoryLabel.text = cellData.title.localized(from: .main)
    }
    
    func setLastCell(isLast: Bool) {
        lineView.isHidden = isLast
    }
    
    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.addArrangedSubview(categoryLabel)
        stack.addArrangedSubview(resultLabel)
        
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(-4)
        }
        
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(4)
            make.width.equalTo(1)
        }
    }
   
}
