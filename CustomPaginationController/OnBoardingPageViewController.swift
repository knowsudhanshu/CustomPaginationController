//
//  OnBoardingPageViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 06/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit


protocol OnBoardingPageViewControllerDelegate: NSObjectProtocol {
    func pageViewControllerDidFinishTransitioningToIndex(_ index: Int)
}

class OnBoardingPageViewController: UIPageViewController {
    var viewControllersList: [UIViewController] = []
    weak var onBoardingPageViewControllerDelegate: OnBoardingPageViewControllerDelegate?

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        
    }
    
    convenience init(viewControllers: [UIViewController]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        viewControllersList = viewControllers
        
        self.setViewControllers([viewControllersList[0]], direction: .forward, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }

}


extension OnBoardingPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let vcIndex = viewControllersList.firstIndex(of: viewController) else { return nil }
        
        let prevIndex = vcIndex - 1
        
        guard prevIndex >= 0 else { return nil }
        
        guard viewControllersList.count > prevIndex else { return nil }
        
        return viewControllersList[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllersList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = vcIndex + 1
        
        guard nextIndex < viewControllersList.count else { return nil }
        
        return viewControllersList[nextIndex]
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed == true {
            guard let currentViewController = pageViewController.viewControllers?.first else { return }
            let currentIndex: Int = viewControllersList.firstIndex(of: currentViewController) ?? 0
            print("currentIndex: \(currentIndex)")
            onBoardingPageViewControllerDelegate?.pageViewControllerDidFinishTransitioningToIndex(currentIndex)
        }
    }
}
