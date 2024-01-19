//
//  TabbarViewController.swift
//  Rebrus
//
//  Created by Alua Sayabayeva on 18/01/2024.
//

import UIKit
class TabBarController: UITabBarController {
    
    let standardAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Montserrat-Medium", size: 16)!, .foregroundColor: ColorManager.blue!]
    let largeTitleAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Montserrat-Regular", size: 28)!, .foregroundColor: ColorManager.black!]
    var chatTabBarItem: UITabBarItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.tintColor = ColorManager.blue
        delegate = self
        
        let mainNavigationController = UINavigationController(rootViewController: createViewController(
            vc: MainViewController(),
            title: "Главная",
            tabBarTitle: "Главная",
            image: UIImage(named: "homeIcon"),
            tag: 0))
        
        let profileNavigationController = UINavigationController(rootViewController: createViewController(
            vc: ProfileViewController(),
            title: "",
            tabBarTitle: "Профиль",
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
    
    func createNavigationControllers(navigations: [UINavigationController]) {
        for nv in navigations {
            nv.navigationBar.titleTextAttributes = standardAttributes
            nv.navigationBar.tintColor = ColorManager.blue
            nv.navigationBar.prefersLargeTitles = false
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
