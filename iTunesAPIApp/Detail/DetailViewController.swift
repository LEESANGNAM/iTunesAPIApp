//
//  DetailViewController.swift
//  iTunesAPIApp
//
//  Created by 이상남 on 2023/11/09.
//

import UIKit

class DetailViewContoller: UIViewController{
    
    let mainView = DetailView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
