//
//  ViewController.swift
//  TableViewExercise
//
//  Created by Prateek Sharma on 5/22/18.
//  Copyright © 2018 Prateek Sharma. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    private var tableDataSource = [
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.",
        "Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC",
        "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.",
        "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.",
        "The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
        "Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
                           ]
    
    private var selectedRows = [IndexPath]()
    
    private var isReorderingEnabled = false
    private var isDeleteEnabled = false
    
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsMultipleSelectionDuringEditing = false
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 300
        }
    }
    
    @IBOutlet private var reorderCellsBarButton: UIBarButtonItem!
    @IBOutlet private var deleteCellsBarButton: UIBarButtonItem!
    
}

// IBActions
extension ViewController {
    
    @IBAction private func reorderCells(_ sender: UIBarButtonItem) {
        
        isReorderingEnabled = !tableView.isEditing

        if isReorderingEnabled {
            sender.title = "Done"
            setDeleteBarButton(hidden: true)
        } else {
            sender.title = "Reorder"
            setDeleteBarButton(hidden: false)
        }
        
        tableView.isEditing = isReorderingEnabled
    }
    
    @IBAction private func deleteCells(_ sender: UIBarButtonItem) {
        
        isDeleteEnabled = !tableView.isEditing
        tableView.allowsMultipleSelectionDuringEditing = isDeleteEnabled
        
        if isDeleteEnabled {
            sender.title = "Delete"
            setReorderBarButton(hidden: true)
        } else {
            sender.title = "Select"
            setReorderBarButton(hidden: false)
            deleteSelectedRows()
        }
        
        tableView.isEditing = isDeleteEnabled
        
    }
    
}

// Custom Helper methods
extension ViewController {

    private func setReorderBarButton(hidden: Bool) {
        if hidden == true {
            self.navigationItem.setRightBarButton(nil, animated: true)
        } else {
            self.navigationItem.setRightBarButton(reorderCellsBarButton, animated: true)
        }
    }
    
    private func setDeleteBarButton(hidden: Bool) {
        if hidden == true {
            self.navigationItem.setLeftBarButton(nil, animated: true)
        } else {
            self.navigationItem.setLeftBarButton(deleteCellsBarButton, animated: true)
        }
    }
    
    private func deleteSelectedRows() {
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
        
        let customCell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        customCell.setup(content: tableDataSource[indexPath.row], for : indexPath.row)
        
        return customCell
        
    }
    
}


// pragma - To Select/Edit/Move TableView Cells
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRows.append(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedRows.delete(element: indexPath)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableDataSource.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        let reloadingIndexPaths = IndexPath.createForNumbers(from: sourceIndexPath.row, to: destinationIndexPath.row)
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


