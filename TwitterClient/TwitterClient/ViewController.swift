//
//  ViewController.swift
//  TwitterClient
//
//  Created by magrus87 on 15/09/2017.
//  Copyright © 2017 ru.magrus87. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var router: AppRouter?
    
    init(router: AppRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.green
        
    }


}

