//
//  IndexPathExtension.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/23/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


extension IndexPath {
    
    static func createForNumbers(from start: Int, to end: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        let loopStep = start <= end ? 1 : -1
        for index in stride(from: start, through: end, by: loopStep) {
            indexPaths.append(IndexPath(row: index, section: 0))
        }
        return indexPaths
    }
    
}
