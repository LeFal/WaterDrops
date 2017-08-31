//
//  ViewController.swift
//  WaterDropExample
//
//  Created by SeanChoi on 2017. 8. 31..
//  Copyright © 2017년 SeanChoi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let waterDropView = WaterDropsView {
            $0.color = UIColor.white
            $0.dropNum = 30
            $0.startAnimation()
        }
        
        self.view.addSubview(waterDropView)
        waterDropView.bindFrameToSuperviewBounds()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension UIView {
    
    func bindFrameToSuperviewBounds() {
        
        guard let superview = self.superview else {
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[subview]-(0)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]-(0)-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }
    
}
