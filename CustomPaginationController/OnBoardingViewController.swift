//
//  OnBoardingViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 06/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    var headerView: PageControlView!
    var pagerViewController: OnBoardingPageViewController!
        
    init(viewControllers: [UIViewController]) {
        // setup pagecontrolview
        headerView = PageControlView(style: PageControlStyle())
        
        // setup pagecontroller
        pagerViewController = OnBoardingPageViewController(viewControllers: viewControllers)
        pagerViewController.view.backgroundColor = .yellow
        
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setupPageProgressView() {
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        headerView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
        headerView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        headerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func setupPagerViewController() {
        pagerViewController.onBoardingPageViewControllerDelegate = self

        self.addChild(pagerViewController)
        
        self.view.addSubview(pagerViewController.view)
        pagerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pagerViewController.view.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            pagerViewController.view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            pagerViewController.view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            pagerViewController.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func setupViewComponents() {
        setupPageProgressView()
        setupPagerViewController()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewComponents()
        updateProgressIndicator()
    }    
    
    // Required init methods
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnBoardingViewController: OnBoardingPageViewControllerDelegate {
    func pageViewControllerDidFinishTransitioningToIndex(_ index: Int) {
        // let the progress bar know about this transition and update accordingly
        updateProgressIndicator(index)
    }
    
    @objc fileprivate func updateProgressIndicator(_ pageIndex: Int = 0) {
        let progress = CGFloat(((pageIndex + 1) * 100) / pagerViewController.viewControllersList.count)
        headerView.progress = progress
    }
}
