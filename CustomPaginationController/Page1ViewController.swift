//
//  Page1ViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 07/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class Page1ViewController: UIViewController, PaginationChildProtocol {
    var containerViewController: OnBoardingViewController
    
    required init(containerViewController: OnBoardingViewController) {
        self.containerViewController = containerViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let footerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Done", for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.backgroundColor = .black
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return button
    }()
    
    fileprivate func setupFooterButton() {
        view.addSubview(footerButton)
        
        footerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        footerButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
        
        footerButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
    }
    
    @objc private func doneAction() {
        containerViewController.goNext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        setupFooterButton()
    }
}
