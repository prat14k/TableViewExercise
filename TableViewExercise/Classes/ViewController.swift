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
    
    @IBOutlet private var editTableBarButton: UIBarButtonItem!
    @IBOutlet private var deleteCellsBarButton: UIBarButtonItem! {
        didSet {
            setDeleteBarButton(hidden: true)
        }
    }
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.allowsMultipleSelectionDuringEditing = true
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.estimatedRowHeight = 300
        }
    }
}


// IBActions
extension ViewController {
    
    @IBAction private func editTableCells(_ sender: UIBarButtonItem) {
        let isEditingEnabled = !tableView.isEditing
        sender.title = isEditingEnabled ? StringLiterals.DisableEditingText : StringLiterals.EnableEditingText
        setDeleteBarButton(hidden: !isEditingEnabled)
        tableView.setEditing(isEditingEnabled, animated: true)
    }
    @IBAction private func deleteCells(_ sender: UIBarButtonItem) {
        deleteSelectedRows()
        editTableBarButton.title = StringLiterals.EnableEditingText
        setDeleteBarButton(hidden: true)
        tableView.setEditing(false, animated: true)
    }
    
}

// Custom Helper methods
extension ViewController {

    private func setDeleteBarButton(hidden: Bool) {
        navigationItem.setLeftBarButton(hidden ? nil : deleteCellsBarButton, animated: true)
    }
    private func deleteSelectedRows() {
        guard let selectedRows = tableView.indexPathsForSelectedRows else { return }
        let indexes = selectedRows.map { $0.row }
        tableDataSource.remove(indexes: indexes)
        tableView.deleteRows(at: selectedRows, with: .fade)
        tableView.reloadData()
    }
    private func recreateSelected(rows: [IndexPath]) {
        for indexPath in rows {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        }
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
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tableDataSource.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        let reloadingIndexPaths = IndexPath.createForNumbers(from: sourceIndexPath.row, to: destinationIndexPath.row)
        let selectedRows = tableView.indexPathsForSelectedRows ?? []
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadRows(at: reloadingIndexPaths, with: .none)
            self?.recreateSelected(rows: selectedRows)
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
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}


