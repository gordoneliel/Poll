//
//  Presentable.swift
//  Poll
//
//  Created by Eliel Gordon on 9/17/16.
//  Copyright © 2016 Eliel Gordon. All rights reserved.
//

import Foundation
import Messages

protocol Presentable {
    func presentOn(view: UIViewController)
}

extension Presentable where Self: UIViewController {
    func presentOn(view viewController: UIViewController) {
        
        // Remove child views
        childViewControllers.forEach { child in
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        
        // Embed the new controller.
        addChildViewController(viewController)
        
        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        viewController.didMove(toParentViewController: self)
    }
}
