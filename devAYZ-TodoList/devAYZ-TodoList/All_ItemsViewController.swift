//
//  ViewController.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.
//

import UIKit
import RealmSwift

class All_ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    // MARK: - Instantiate instance of All_Items views
    let listViews = All_ItemsViews()
    
    private let realm = try! Realm()
    public var completionHandler: ( () -> Void)?
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.592452511, green: 0.5285605736, blue: 0.5285605736, alpha: 1)
        
        listViews.todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        listViews.todoTable.delegate = self
        listViews.todoTable.dataSource = self
        
        listViews.newTodoField.delegate = self
        
        // Top View
        setupTodoTopView()
        
        // Down View
        if todoListIsEmpty() {
            setupEmptyTodoView()
            
        } else {
            setupTodoTableView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        realm.objects(ItemsModel.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentItem = realm.objects(ItemsModel.self)
        cell.textLabel?.text = "\(indexPath.row + 1).      \(currentItem[indexPath.row].todoData)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listViews.todoTable.deselectRow(at: indexPath, animated: true)
        
        let currentItem = UINavigationController(rootViewController: Current_ItemViewController() )
        present(currentItem, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive,
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
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func setupTodoTopView() {
        
        // Add Top UIView to view
        view.addSubview(listViews.todoTopView)
        NSLayoutConstraint.activate([
            listViews.todoTopView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            listViews.todoTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listViews.todoTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listViews.todoTopView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
        ])
        
        // Adding Subviews to Top View
        listViews.todoTopView.addSubview(listViews.newTodoField)
        
        listViews.addNewTodoBtn.addTarget(self, action: #selector(addItem) , for: .touchUpInside )
        listViews.todoTopView.addSubview(listViews.addNewTodoBtn)
        
        NSLayoutConstraint.activate([
            listViews.newTodoField.leadingAnchor.constraint(equalTo: listViews.todoTopView.leadingAnchor, constant: 30),
            listViews.newTodoField.centerYAnchor.constraint(equalTo: listViews.todoTopView.centerYAnchor),
            listViews.newTodoField.heightAnchor.constraint(equalToConstant: 40),
            listViews.newTodoField.widthAnchor.constraint(equalToConstant: 250),
            listViews.newTodoField.trailingAnchor.constraint(equalTo: listViews.addNewTodoBtn.leadingAnchor, constant: -20),
            
            listViews.addNewTodoBtn.centerYAnchor.constraint(equalTo: listViews.newTodoField.centerYAnchor),
            listViews.addNewTodoBtn.leadingAnchor.constraint(equalTo: listViews.newTodoField.trailingAnchor, constant: 20),
            listViews.addNewTodoBtn.heightAnchor.constraint(equalToConstant: 40),
            listViews.addNewTodoBtn.widthAnchor.constraint(equalToConstant: 80),
            listViews.addNewTodoBtn.trailingAnchor.constraint(equalTo: listViews.todoTopView.trailingAnchor, constant: -30)
        ])
    }
    
    func setupEmptyTodoView() {
        
        view.addSubview(listViews.emptyTodoLabel)
        
        NSLayoutConstraint.activate([
            listViews.emptyTodoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listViews.emptyTodoLabel.topAnchor.constraint(equalTo: listViews.todoTopView.bottomAnchor),
            listViews.emptyTodoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listViews.emptyTodoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupTodoTableView() {
        view.addSubview( listViews.todoTable)
        
        NSLayoutConstraint.activate([
            listViews.todoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listViews.todoTable.topAnchor.constraint(equalTo: listViews.todoTopView.bottomAnchor),
            listViews.todoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listViews.todoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        listViews.newTodoField.resignFirstResponder()
        
        return true
    }
    
    // MARK: - Add item click action
    @objc func addItem() {
        guard let text = listViews.newTodoField.text else {
            return
        }
        
        if !text.isEmpty, !text.first!.isWhitespace, text.count > 1 {
            
            saveDataToRealm(todoText: text)
            
        }  else if !text.isEmpty, text.first!.isWhitespace {
            present(listViews.errorFirstCharacterAlert, animated: true, completion: nil)
            
        } else if !text.isEmpty, text.count <= 1{
            present(listViews.errorListLengthAlert, animated: true, completion: nil)
            
        } else {
            
            present(listViews.emptyListAlert, animated: true, completion: nil)
        }
        
        listViews.newTodoField.resignFirstResponder()
        listViews.newTodoField.text = String()
        self.refresh()
    }
    
    // MARK: - Function to reload data
    func refresh() {
        if todoListIsEmpty(), let text = listViews.newTodoField.text, !text.isEmpty  {
            setupTodoTableView()
        }
        listViews.todoTable.reloadData()
    }

}

