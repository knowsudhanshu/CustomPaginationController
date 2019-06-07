//
//  Page3ViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 07/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class Page3ViewController: UIViewController, PaginationChildProtocol {
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
        view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
