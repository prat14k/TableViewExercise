//
//  ArrayExtension.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/22/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func move(from source: Int , to destination: Int) {
        let item = remove(at: source)
        insert(item, at: destination)
    }

    mutating func remove(indexes: [Int]) {
        
        guard count > 0  else { return }
        
        var newArray = [Element]()
        for index in 0..<count {
            if !indexes.contains(index) {
                newArray.append(self[index])
            }
        }
        
        self = newArray
    }
    
}

extension Array where Element: Equatable {
    
    mutating func delete(element: Element) -> Element? {
        guard let index = self.index(of: element)  else { return nil }
        return self.remove(at: index)
    }
    
}
