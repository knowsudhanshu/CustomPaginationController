//
//  Page2ViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 07/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class Page2ViewController: UIViewController, PaginationChildProtocol {
    var containerViewController: OnBoardingViewController
    
    required init(containerViewController: OnBoardingViewController) {
        self.containerViewController = containerViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}
