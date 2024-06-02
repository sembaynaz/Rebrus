//
//  OnboardingViewController.swift
//  Rebrus
//
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    private let dataSource: [Onboarding] = [
        Onboarding(text: "Попрощайтесь 👋 с бумажной работой".localized(from: .onboard), imageName: "onboard1"),
        Onboarding(text: "Система сама проанализирует ".localized(from: .onboard), imageName: "onboard2"),
        Onboarding(text: "Удобный доступ к заметкам в любом месте".localized(from: .onboard), imageName: "onboard3")
    ]
    
    private lazy var currentPage = 0 {
        didSet {
            pageControll.currentPage = currentPage
        }
    }
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            OnboardingCollectionViewCell.self,
            forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset.left = 0
        collectionView.contentInset.right = 0
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = ColorManager.blue
        
        return collectionView
    }()
    
    private lazy var pageControll: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor(white: 1, alpha: 0.3)
        pc.currentPageIndicatorTintColor = .white
        pc.currentPage = currentPage
        pc.numberOfPages = 3
        return pc
    }()
    
    private let startButton: Button = {
        let button = Button()
        button.setActive(.white, ColorManager.blue ?? .blue)
        button.setTitle("Приступить".localized(from: .onboard), for: .normal)
        return button
    }()
    
    private let loginButton: Button = {
        let button = Button()
        button.setActive(ColorManager.blue ?? .blue, .white)
        button.setTitle("Войти в систему".localized(from: .onboard), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorManager.blue
        setupConstraints()
    }
    
}

extension OnboardingViewController {
    private func setupConstraints() {
        setLoginButton()
        setStartButton()
        setPageControl()
        setCollectionView()
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(pageControll.snp.top).offset(-30)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(453)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    private func setPageControl() {
        view.addSubview(pageControll)
        
        pageControll.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(startButton.snp.top).offset(-20)
        }
    }
    
    private func setStartButton() {
        view.addSubview(startButton)
        
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(53)
            make.height.equalTo(52)
            make.bottom.equalTo(loginButton.snp.top).offset(-5)
        }
    }
    
    private func setLoginButton() {
        view.addSubview(loginButton)

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        loginButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(53)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().offset(-76)
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setCell(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cellWidth = collectionView.bounds.width
        let cellHeight = collectionView.bounds.height

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControll.currentPage = currentPage
    }
}


extension OnboardingViewController {
    @objc func loginButtonTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }

    @objc func startButtonTapped() {
        if pageControll.currentPage < dataSource.count - 1 {
            pageControll.currentPage += 1
            let indexPath = IndexPath(item: pageControll.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            let vc = StartViewController()
            vc.modalPresentationStyle = .fullScreen
            show(vc, sender: self)
        }
    }
}
