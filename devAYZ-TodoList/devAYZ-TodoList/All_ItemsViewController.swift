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
    
    let todoTopView = UIView()
    
    let emptyTodoLabel = UITextView()
    let todoTable = UITableView()
    
    private let realm = try! Realm()
    public var completionHandler: ( () -> Void)?
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.592452511, green: 0.5285605736, blue: 0.5285605736, alpha: 1)
        
        todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        todoTable.delegate = self
        todoTable.dataSource = self
        
        listViews.newTodoField.delegate = self
        
        // MARK: - Top View
        setupTodoTopView()
        
        // MARK: - Down View
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
        todoTable.deselectRow(at: indexPath, animated: true)
        
        let currentItem = UINavigationController(rootViewController: Current_ItemViewController() )
        present(currentItem, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive,
                                        title: "Delete") { [self] (action, view, completionHandler)  in
            
            try! realm.write{
                
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
    
    
    func setupTodoTopView() {
        
        // MARK: - Top UIView
        todoTopView.backgroundColor = #colorLiteral(red: 0.8767417073, green: 0.782191131, blue: 0.782191131, alpha: 1)
        todoTopView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoTopView)
        
        NSLayoutConstraint.activate([
            todoTopView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            todoTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoTopView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
        ])
        
        
        // MARK: - Adding Subviews to Top View
        todoTopView.addSubview(listViews.newTodoField)
        
        listViews.addNewTodoBtn.addTarget(self, action: #selector(addItem) , for: .touchUpInside )
        todoTopView.addSubview(listViews.addNewTodoBtn)
        
        
        NSLayoutConstraint.activate([
//            newTodoField.centerXAnchor.constraint(equalTo: todoTopView.centerXAnchor),
            listViews.newTodoField.leadingAnchor.constraint(equalTo: todoTopView.leadingAnchor, constant: 30),
            listViews.newTodoField.centerYAnchor.constraint(equalTo: todoTopView.centerYAnchor),
            listViews.newTodoField.heightAnchor.constraint(equalToConstant: 40),
            listViews.newTodoField.widthAnchor.constraint(equalToConstant: 250),
            listViews.newTodoField.trailingAnchor.constraint(equalTo: listViews.addNewTodoBtn.leadingAnchor, constant: -20),
            
            listViews.addNewTodoBtn.centerYAnchor.constraint(equalTo: listViews.newTodoField.centerYAnchor),
            listViews.addNewTodoBtn.leadingAnchor.constraint(equalTo: listViews.newTodoField.trailingAnchor, constant: 20),
            listViews.addNewTodoBtn.heightAnchor.constraint(equalToConstant: 40),
            listViews.addNewTodoBtn.widthAnchor.constraint(equalToConstant: 80),
            listViews.addNewTodoBtn.trailingAnchor.constraint(equalTo: todoTopView.trailingAnchor, constant: -30)
            
        ])
    }
    
    
    // MARK: - Add new item retrieval
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        listViews.newTodoField.resignFirstResponder()
        
        return true
    }
    
    
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
    
    
    func refresh() {
        if todoListIsEmpty(), let text = listViews.newTodoField.text, !text.isEmpty  {
            setupTodoTableView()
        }
        todoTable.reloadData()
    }
    
    
    func setupEmptyTodoView() {
        emptyTodoLabel.text = TextConstant.emptyLabelText
        emptyTodoLabel.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)
        emptyTodoLabel.textAlignment = .center
        emptyTodoLabel.textColor = #colorLiteral(red: 0.2929826677, green: 0.1407194802, blue: 0.1434625629, alpha: 1)
        emptyTodoLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyTodoLabel.isEditable = false
        emptyTodoLabel.isSelectable = false
        view.addSubview(emptyTodoLabel)
        
        NSLayoutConstraint.activate([
            emptyTodoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyTodoLabel.topAnchor.constraint(equalTo: todoTopView.bottomAnchor),
            emptyTodoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyTodoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
        ])
    }
    
    func setupTodoTableView() {
        todoTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoTable)
        
        NSLayoutConstraint.activate([
            todoTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            todoTable.topAnchor.constraint(equalTo: todoTopView.bottomAnchor),
            todoTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

}

