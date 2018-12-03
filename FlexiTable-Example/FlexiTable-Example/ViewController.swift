//
//  ViewController.swift
//  FlexiTable
//
//  Created by Shayne Brady on 30/11/18.
//  Copyright © 2018 Shayne Brady. All rights reserved.
//

import UIKit
import FlexiTable

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func demo1Selected(_ sender: Any) {
        let parallaxVC = ParallaxHeaderDemoViewController.init()
        self.navigationController?.pushViewController(parallaxVC, animated: true)
    }
    
    @IBAction func withoutNavSelected(_ sender: Any) {
        let noNavVC = WithoutHeaderViewController.init()
        self.navigationController?.pushViewController(noNavVC, animated: true)

    }
    
    @IBAction func modalSelected(_ sender: Any) {
        let parallaxVC = ParallaxHeaderDemoViewController.init()
        
        let navVC = UINavigationController.init(rootViewController: parallaxVC)
        
       self.present(navVC, animated: true, completion: nil)

    }
    
    @IBAction func manySegmentsSelected(_ sender: Any) {
        let manySegmentsVC = ManySegmentsViewController.init()
        self.navigationController?.pushViewController(manySegmentsVC, animated: true)

    }
    
    @IBAction func profileSelected(_ sender: Any) {
        let profileVC = ProfileViewController.init()
        self.navigationController?.pushViewController(profileVC, animated: true)

    }
    

}

