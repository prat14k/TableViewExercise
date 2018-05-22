//
//  BarButtonExtension.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/22/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    func show() {
        self.tintColor = UIColor.blue
        self.isEnabled = true
    }
    
    func hide() {
        self.tintColor = UIColor.clear
        self.isEnabled = false
    }
    
}
