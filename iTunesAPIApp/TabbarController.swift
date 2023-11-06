//
//  ViewController.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/07.
//

import UIKit

class TabbarController: UITabBarController {
    let searchVC = UINavigationController(rootViewController: SearchViewController())
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [searchVC]
        setupTabbar()
    }
    
    private func setupTabbar(){
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
        tabBar.backgroundColor = .systemBackground
        setupTabbarItem()
    }
    
    private func setupTabbarItem(){
        searchVC.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
    }
    
    
}

