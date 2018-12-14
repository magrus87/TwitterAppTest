//
//  AppRouter.swift
//  TwitterClient
//
//  Created by magrus87 on 18/09/2017.
//  Copyright © 2017 ru.magrus87. All rights reserved.
//

import UIKit

final class AppRouter: NSObject {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    public func showAuthViewController() {
        let viewController = ViewController(router: self)
        navigationController.pushViewController(viewController, animated: false)
    }
}
