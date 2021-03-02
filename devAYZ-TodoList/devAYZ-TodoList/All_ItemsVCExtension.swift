//
//  TodoListVCExtension.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.
//

import Foundation
import UIKit

extension All_ItemsViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realm.objects(ItemsModel.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentItem = realm.objects(ItemsModel.self)
        cell.textLabel?.text = "\(indexPath.row + 1).      \(currentItem[indexPath.row].todoData)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        cell.textLabel?.numberOfLines = 0;
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewLists.todoTable.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive,
                                        title: "Delete") { [self] (action, view, completionHandler)  in
            try! realm.write {
                let deleteItem = realm.objects(ItemsModel.self)
                realm.delete(deleteItem[indexPath.row])
            }
            self.refresh()
            
            if todoListIsEmpty() {
                setupEmptyTodoView()
            }
        }
        
        // MARK: - Update realm here in handler below
        
        let actionEdit = UIContextualAction(style: .normal,
                                            title: "Edit") { [self] (action, view, completionHandler)  in
            
            let editAlert = UIAlertController(title: "EDIT ITEM", message: "Edit Your Todo Item", preferredStyle: .alert)
            
            let currenttem = realm.objects(ItemsModel.self).map{ $0 }
            
            editAlert.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                let heightConstraint = NSLayoutConstraint(item: textField!, attribute: .height,
                                                          relatedBy: .equal, toItem: nil,
                                                          attribute: .notAnAttribute, multiplier: 1,
                                                          constant: 80)
                textField.addConstraint(heightConstraint)
            })
            editAlert.textFields?.first?.text = currenttem[indexPath.row].todoData
            
            editAlert.addAction(UIAlertAction(title: "Update Item", style: .default, handler: { [weak self] _ in
                
                try! realm.write{
                    currenttem[indexPath.row].todoData = (editAlert.textFields?.first?.text)!
                }
                self!.refresh()
            }))
            self.present(editAlert, animated: true, completion: nil)
            
        }
        actionEdit.backgroundColor = .systemOrange
        
        let configuration = UISwipeActionsConfiguration(actions: [actionDelete, actionEdit])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func setupTodoTopView() {
        
        // Add Top UIView to view
        view.addSubview(viewLists.todoTopView)
        NSLayoutConstraint.activate([
            viewLists.todoTopView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            viewLists.todoTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewLists.todoTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewLists.todoTopView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
        ])
        
        // Adding Subviews to Top View
        viewLists.todoTopView.addSubview(viewLists.newTodoField)
        
        viewLists.addNewTodoBtn.addTarget(self, action: #selector(addItem) , for: .touchUpInside )
        viewLists.todoTopView.addSubview(viewLists.addNewTodoBtn)
        
        NSLayoutConstraint.activate([
            viewLists.newTodoField.leadingAnchor.constraint(equalTo: viewLists.todoTopView.leadingAnchor, constant: 30),
            viewLists.newTodoField.centerYAnchor.constraint(equalTo: viewLists.todoTopView.centerYAnchor),
            viewLists.newTodoField.heightAnchor.constraint(equalToConstant: 40),
            viewLists.newTodoField.widthAnchor.constraint(equalToConstant: 250),
            viewLists.newTodoField.trailingAnchor.constraint(equalTo: viewLists.addNewTodoBtn.leadingAnchor, constant: -20),
            
            viewLists.addNewTodoBtn.centerYAnchor.constraint(equalTo: viewLists.newTodoField.centerYAnchor),
            viewLists.addNewTodoBtn.leadingAnchor.constraint(equalTo: viewLists.newTodoField.trailingAnchor, constant: 20),
            viewLists.addNewTodoBtn.heightAnchor.constraint(equalToConstant: 40),
            viewLists.addNewTodoBtn.widthAnchor.constraint(equalToConstant: 80),
            viewLists.addNewTodoBtn.trailingAnchor.constraint(equalTo: viewLists.todoTopView.trailingAnchor, constant: -30)
        ])
    }
    
    func setupEmptyTodoView() {
        
        view.addSubview(viewLists.emptyTodoLabel)
        
        NSLayoutConstraint.activate([
            viewLists.emptyTodoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewLists.emptyTodoLabel.topAnchor.constraint(equalTo: viewLists.todoTopView.bottomAnchor),
            viewLists.emptyTodoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewLists.emptyTodoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupTodoTableView() {
        view.addSubview( viewLists.todoTable)
        
        NSLayoutConstraint.activate([
            viewLists.todoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewLists.todoTable.topAnchor.constraint(equalTo: viewLists.todoTopView.bottomAnchor),
            viewLists.todoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewLists.todoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    
    // MARK: - Check if realm database is empty
    func todoListIsEmpty() -> Bool {
        realm.isEmpty
    }
    
    func saveDataToRealm(todoText text: String) {
        if todoListIsEmpty() {
            setupTodoTableView()
        }
        try! realm.write{
            let newItem = ItemsModel()
            newItem.todoData = text
            realm.add(newItem)
        }
        
    }
    
    // MARK: - Add new item retrieval
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewLists.newTodoField.resignFirstResponder()
        
        return true
    }
    
    
    // MARK: - Add item click action
    @objc func addItem() {
        guard let text = viewLists.newTodoField.text else {
            return
        }
        
        if !text.isEmpty, !text.first!.isWhitespace, text.count > 1 {
            
            saveDataToRealm(todoText: text)
            
        }  else if !text.isEmpty, text.first!.isWhitespace {
            present(viewLists.errorFirstCharacterAlert, animated: true, completion: nil)
            
        } else if !text.isEmpty, text.count <= 1{
            present(viewLists.errorListLengthAlert, animated: true, completion: nil)
            
        } else {
            
            present(viewLists.emptyListAlert, animated: true, completion: nil)
        }
        
        viewLists.newTodoField.resignFirstResponder()
        viewLists.newTodoField.text = String()
        self.refresh()
    }
    
    // MARK: - Function to reload data
    func refresh() {
        if todoListIsEmpty(), let text = viewLists.newTodoField.text, !text.isEmpty  {
            setupTodoTableView()
        }
        viewLists.todoTable.reloadData()
    }
}
