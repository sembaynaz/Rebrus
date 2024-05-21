//
//  OnboardingCollectionViewCell.swift
//  Rebrus
//
//

import UIKit

struct Onboarding {
    let text: String
    let imageName: String
}

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 35)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("error")
    }
    
    func setCell(with content: Onboarding) {
        label.text = content.text
        image.image = UIImage(named: content.imageName)
    }
    
    private func setupUI() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 50
        stack.addArrangedSubview(image)
        stack.addArrangedSubview(label)
        
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(230)
        }
    }
   
}
