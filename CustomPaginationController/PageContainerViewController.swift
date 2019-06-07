//
//  PageContainerViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 06/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

protocol PaginationChildProtocol where Self: UIViewController  {
    var containerViewController: PageContainerViewController {get set}
    init(containerViewController: PageContainerViewController)
}

class PageContainerViewController: UIViewController {
    
    var headerView: PageControlView!
    var pagerViewController: PageViewController? = nil
    var navigationView: UIStackView = {
        let view = UIView()
        
        let prevButton = UIButton(type: .custom)
        prevButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        prevButton.setTitle("Prev", for: .normal)
        prevButton.addTarget(self, action: #selector(prevAction), for: .touchUpInside)
        
        let nextButton = UIButton(type: .custom)
        nextButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [prevButton, nextButton])
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    @objc private func prevAction() {
        self.goBack()
    }
    
    @objc private func nextAction() {
        self.goNext()
    }
    
    var viewControllers: [UIViewController]? = nil {
        didSet {
            headerView = PageControlView(style: PageControlStyle())

            // setup pagecontroller
            guard let vcs = viewControllers else { return }
            pagerViewController = PageViewController(viewControllers: vcs)
            pagerViewController?.view.backgroundColor = .white
        }
    }
    
    private func setupPageProgressView() {
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        headerView.heightAnchor.constraint(equalToConstant: UIApplication.shared.statusBarFrame.height)
        ])
        
    }
    
    private func setupNavView() {
        self.view.addSubview(navigationView)
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            navigationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    
    private func setupPagerViewController() {
        guard let pagerViewController = pagerViewController else { return }
        
        pagerViewController.pageViewControllerDelegate = self

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
        
        setupNavView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers =
            [Page1ViewController(containerViewController: self),
             Page2ViewController(containerViewController: self),
             Page3ViewController(containerViewController: self)]

        setupViewComponents()
        updateProgressIndicator()
    }
    
    // public func
    func goNext() {
        pagerViewController?.goToNextPage()
    }
    
    func goBack() {
        pagerViewController?.goToPreviousPage()
    }
    
    // Required init methods
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageContainerViewController: PageViewControllerDelegate {
    
    func pageViewController(_ pageController: PageViewController, scrollTo index: Int) {
        updateProgressIndicator(index)
    }
    
    func pageViewController(_ pageController: PageViewController, didScrollIndex index: Int) {
        // let the progress bar know about this transition and update accordingly
        print("index: \(index)")
        updateProgressIndicator(index)
    }
    
    @objc fileprivate func updateProgressIndicator(_ pageIndex: Int = 0) {
        let progress = CGFloat(((pageIndex + 1) * 100) / pagerViewController!.viewControllersList.count)
        headerView.progress = progress
    }
}
