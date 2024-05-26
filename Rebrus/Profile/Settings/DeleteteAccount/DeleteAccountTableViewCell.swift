//
//  DeleteAccountTableViewCell.swift
//  Rebrus
//
//

import UIKit

class DeleteAccountTableViewCell: UITableViewCell {

    static let identifier = "DeleteAccountTableViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 15)
        label.textColor = ColorManager.black
        return label
    }()
    
    private let checkboxView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "checkNonactive")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        setupUI()
    }
    
    func setContent(with text: String) {
        label.text = text
    }
    
    func setSelected(isSelected: Bool) {
        checkboxView.image = UIImage(named: isSelected ? "checkActive" : "checkNonactive")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - UI setups
extension DeleteAccountTableViewCell {
    private func setupUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(13)
        }
        
        contentView.addSubview(checkboxView)
        checkboxView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
    }
}
