//
//  PageViewController.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 06/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit


protocol PageViewControllerDelegate: NSObjectProtocol {
    func pageViewController(_ pageController: PageViewController, scrollTo index: Int)
    func pageViewController(_ pageController: PageViewController, didScrollIndex index: Int)
}

class PageViewController: UIPageViewController {
    var viewControllersList: [UIViewController] = []
    weak var pageViewControllerDelegate: PageViewControllerDelegate?

    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        
    }
    
    convenience init(viewControllers: [UIViewController]) {
        self.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        viewControllersList = viewControllers
        
        self.setViewControllers([viewControllersList[0]], direction: .forward, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
    }
    
    // Required init methods
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageViewController: UIPageViewControllerDataSource {

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

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            guard let currentViewController = pageViewController.viewControllers?.first else { return }
            
            let currentIndex: Int = viewControllersList.firstIndex(of: currentViewController) ?? 0

            updateIndex(currentIndex)
        }
    }
}

extension PageViewController {
    
    func goToNextPage(){
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let nextViewController = dataSource?.pageViewController( self, viewControllerAfter: currentViewController ) else { return }
        
        setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)

        
        let currentIndex: Int = viewControllersList.firstIndex(of: currentViewController) ?? 0
        
        updateIndex(currentIndex + 1)
    }
    
    func goToPreviousPage(){
        
        guard let currentViewController = self.viewControllers?.first else { return }
        
        guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return }
        
        setViewControllers([previousViewController], direction: .reverse, animated: true, completion: nil)

        let currentIndex: Int = viewControllersList.firstIndex(of: currentViewController) ?? 0
        
        updateIndex(currentIndex - 1)
    }
    
    private func updateIndex(_ index: Int) {
        guard (index >= 0 && index < viewControllersList.count) else { return }
        pageViewControllerDelegate?.pageViewController(self, didScrollIndex: index)
    }
}
