//
//  ViewController.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/22/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var tableDataSource = [
        "Qg25wHZKp2n4lRS6WZij44yjsFAspVSmgkVEXXdfNNhtwScEqP6WIPLNKVoKpXtUxQvMxpB39J1QIQuwrLQK2Mj5z2" ,
        "TBPsAWMVgA0UrV0lSJsWczmNPe640qWfI9mtlxklO2YPyAPE9Aa5qZjIA05SgmBeLGZ2SDIIZmiVYR8XZ0wtKh79eT" ,
        "ehL3bxPJz5O9b50e7AK30Vw8NYIkRXl42zBSmV3I60SCNeIMnQwiKCLXRrfIcEsQIGy8jvvJyOoITQExnalBfeLO15L0QmyKabQNvWl4ey6KTYkK5VsdgauM" ,
        "fZ7mg1TZiHnNmoaxogdQs6KQJxfLRBfV7In6txNrB3BdXuohqv" ,
        "v0SY2" ,
        "vJ8RZTWuMD10sIG54XOIVAvWkKdIYlH9Jj9F5sHYIxofvwBY4iEifusw1tLS1GuJBV6IPLZP2iEWxkm31vxM0Wch40mtSClh8sVZwjPHn" ,
        "NxpSOvdEWASigMCzng5uZUxM3PtTqO"
                           ]
    
    var selectedRows = [IndexPath]()
    
    var isReorderingEnabled = false
    var isDeleteEnabled = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reorderCellsBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteCellsBarButton: UIBarButtonItem!
    
}


extension ViewController {
    
    private struct TableCellIdentifiers {
        static let CustomCell = "customCellIdentifier"    // Appropriate name can be given as per the purpose/content the cell have
    }
    
}


// Overriden Methods
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
}

// IBActions
extension ViewController {
    
    @IBAction func reorderCells(_ sender: UIBarButtonItem) {
        
        isReorderingEnabled = !tableView.isEditing

        if isReorderingEnabled {
            sender.title = "Done"
            deleteCellsBarButton.hide()
        }
        else {
            sender.title = "Edit"
            deleteCellsBarButton.show()
        }
        
        tableView.isEditing = isReorderingEnabled
    }
    
    @IBAction func deleteCells(_ sender: UIBarButtonItem) {
        
        isDeleteEnabled = !tableView.isEditing
        tableView.allowsMultipleSelectionDuringEditing = isDeleteEnabled
        
        if isDeleteEnabled {
            sender.title = "Delete"
            reorderCellsBarButton.hide()
        }
        else {
            sender.title = "Select"
            reorderCellsBarButton.show()
            deleteSelectedRows()
        }
        
        tableView.isEditing = isDeleteEnabled
        
    }
    
}

// Custom Helper methods
extension ViewController {

    func deleteSelectedRows() {
        let indexes = selectedRows.map { $0.row }
        tableDataSource.remove(indexes: indexes)
        
        tableView.deleteRows(at: selectedRows, with: .fade)
        
        selectedRows.removeAll()
        tableView.reloadData()
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.CustomCell, for: indexPath) as! CustomTableViewCell
        customCell.setup(content: tableDataSource[indexPath.row], for : indexPath.row)
        
        return customCell
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
 
}

// pragma - To Select/Edit/Move TableView Cells
extension ViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRows.append(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedRows.delete(element: indexPath)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableDataSource.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        let reloadingIndexPaths = IndexPath.createFromRange(a: sourceIndexPath.row, b: destinationIndexPath.row)
        DispatchQueue.main.async {
            tableView.reloadRows(at: reloadingIndexPaths, with: .none)
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableDataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
}

// pragma - Settings for Edit/Move TableViewCell
extension ViewController {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return isReorderingEnabled
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return isReorderingEnabled ? .none : .delete
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return isDeleteEnabled
    }
    
}


