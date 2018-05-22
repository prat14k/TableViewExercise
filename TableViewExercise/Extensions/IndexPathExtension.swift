//
//  IndexPathExtension.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/23/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension IndexPath {
    
    static func createFromRange(a: Int, b: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        let upperBound = Swift.max(a, b)
        let lowerBound = Swift.min(a, b)
        
        for index in lowerBound...upperBound {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        return indexPaths
    }
    
}
