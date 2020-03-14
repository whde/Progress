//
//  ViewController.swift
//  Progress
//
//  Created by whde on 16/4/7.
//  Copyright © 2016年 whde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let progress:WhdeProgress = WhdeProgress.init(frame: CGRectMake(0, 0, 300, 300))
        progress.center = self.view.center
        self.view.addSubview(progress)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

