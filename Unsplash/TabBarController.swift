//
//  TabBarController.swift
//  Unsplash
//
//  Created by Tatina Dzhakypbekova on 12/8/24.
//

import UIKit

class TabBarController: UITabBarController {
   
    let homeVC = HomeViewController()
    let searchVC = SearchViewController()
    let addVC = AddViewController()
    let logIn = LogInViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
 
    }
    func setupTabBar(){
        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "photo.fill"), selectedImage: UIImage(systemName: "photo.fill"))
        searchVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        addVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.app.fill"),selectedImage: UIImage(systemName: "plus.app.fill"))
        logIn.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle.fill"), selectedImage: UIImage(systemName:"person.circle.fill"))
        tabBar.backgroundColor = .systemBackground
        setViewControllers([homeVC, searchVC, addVC, logIn], animated: true)
        
    }
 
}
