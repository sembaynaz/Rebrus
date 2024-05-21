//
//  TabbarViewController.swift
//  Rebrus
//
//

import UIKit
class TabBarController: UITabBarController {
    
    let standardAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Montserrat-Medium", size: 16)!, .foregroundColor: ColorManager.blue!]
    var chatTabBarItem: UITabBarItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = ColorManager.blue
        delegate = self
        
        let mainNavigationController = UINavigationController(rootViewController: createViewController(
            vc: MainViewController(),
            title: "",
            tabBarTitle: "Главная".localized(from: .main),
            image: UIImage(named: "homeIcon"),
            tag: 0))
        
        let profileNavigationController = UINavigationController(rootViewController: createViewController(
            vc: ProfileViewController(),
            title: "",
            tabBarTitle: "Профиль".localized(from: .main),
            image: UIImage(named: "profileIcon"), tag: 1)
        )
        
        let arrayVC = [mainNavigationController, profileNavigationController]
        createNavigationControllers(navigations: arrayVC)
        viewControllers = arrayVC
    }
    
    func createViewController(vc: UIViewController, title: String, tabBarTitle: String, image: UIImage?, tag: Int) -> UIViewController{
        let vc = vc
        vc.title = title
        vc.view.backgroundColor = .white
        vc.tabBarItem = UITabBarItem(title: tabBarTitle, image: image, tag: tag)
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStrings()
        NotificationCenter.default.addObserver(self, selector: #selector(setStrings), name: Notification.Name("localize"), object: nil)
    }
    
    @objc func setStrings() {
        tabBar.items?[0].title = "Главная".localized(from: .main)
        tabBar.items?[1].title = "Профиль".localized(from: .main)
    }
    
    func createNavigationControllers(navigations: [UINavigationController]) {
        for nv in navigations {
            nv.customize()
        }
    }
    
    @objc func changeIndex(notification: NSNotification) {
        let index = notification.userInfo?["index"] as! Int
        self.selectedIndex = index
        animateTabBarItem(index)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        animateTabBarItem(index)
    }
    
    func animateTabBarItem(_ index: Int) {
        guard let tabItems = tabBar.items else { return }
        let selectedTabBarItem = tabItems[index]
        if let view = selectedTabBarItem.value(forKey: "view") as? UIView {
            UIView.animate(withDuration: 0.15, animations: {
                view.transform = CGAffineTransform(scaleX: 1.07, y: 1.07)
            }) { (_) in
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.2) {
                        view.transform = CGAffineTransform.identity
                    }
                }
            }
        }
    }
}
