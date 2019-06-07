//
//  PageControlView.swift
//  CustomPaginationController
//
//  Created by Sudhanshu Sudhanshu on 06/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit

struct PageControlStyle {
    let backgroundColor: UIColor = .white
    let progressColor: UIColor = UIColor(red: 223/255, green: 83/255, blue: 42/255, alpha: 1.0)
    let progressContainerColor: UIColor = UIColor(red: 224/255, green: 207/255, blue: 191/255, alpha: 1.0)
}

let PROGRESS_BAR_HEIGHT: CGFloat = 2.0

class PageControlView: UIView {
    private let progressView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let progressContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    var progressViewWidthConstraint: NSLayoutConstraint!
    var progress: CGFloat = 1 {
        // 0...1
        didSet {
            print("progress: \(progress)")
            perform(#selector(updateProgressIndicator), with: nil, afterDelay: 0)
        }
    }
    
    @objc fileprivate func updateProgressIndicator() {
        let width = progressContainerView.bounds.width * (progress / 100)
        
        UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.progressViewWidthConstraint.constant = width
            self.progressView.layoutIfNeeded()
            self.progressContainerView.layoutIfNeeded()
        })
    }
    
    convenience init(style: PageControlStyle) {
        self.init(frame: .zero)
        
        progressContainerView.addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        progressViewWidthConstraint = NSLayoutConstraint.init(item: progressView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        progressViewWidthConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: progressContainerView.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: progressContainerView.leadingAnchor),
            progressView.bottomAnchor.constraint(equalTo: progressContainerView.bottomAnchor)
            ])
        
        addSubview(progressContainerView)
        progressContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressContainerView.heightAnchor.constraint(equalToConstant: PROGRESS_BAR_HEIGHT),
            progressContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            progressContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            progressContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        
        self.backgroundColor = style.backgroundColor
        self.progressView.backgroundColor = style.progressColor
        self.progressContainerView.backgroundColor = style.progressContainerColor        
    }
    
    // Required init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
