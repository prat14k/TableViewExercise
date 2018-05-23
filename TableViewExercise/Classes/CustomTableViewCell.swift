//
//  CustomTableViewCell.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/22/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier = "customCellIdentifier"
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var backgroundImageView: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.clear
        selectedBackgroundView = selectionView
        
    }
    
}


    
extension CustomTableViewCell {

    func setup(content: String, for rowNumber: Int) {
        
        titleLabel.text = content
        
        let backgroundImageName = rowNumber % 2 == 0 ? ImageAssetNames.BlueMatte : ImageAssetNames.GreenThreads
        backgroundView = UIImageView(image: UIImage(named: backgroundImageName))
        
    }

}
