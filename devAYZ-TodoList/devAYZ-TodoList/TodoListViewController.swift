//
//  ViewController.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var items = [TodoListItem]()
    
    let todoTopView = UIView()
    let emptyTodoLabel = UITextView()
    let todoTable = UITableView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.8767417073, green: 0.782191131, blue: 0.782191131, alpha: 1)
        
        todoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        todoTable.delegate = self
        todoTable.dataSource = self
        

        items.append(TodoListItem())
        items.append(TodoListItem())
        debugPrint(TodoListItem.id)
        debugPrint(items.count)
        
        setupTodoTopView()
        if items.isEmpty {
            setupEmptyTodoView()
        } else {
            setupTodoTableView()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].todoData
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todoTable.deselectRow(at: indexPath, animated: true)
    }
    
    
    func setupTodoTopView() {
        
        todoTopView.backgroundColor = .systemRed
        todoTopView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoTopView)
        
        NSLayoutConstraint.activate([
            todoTopView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            todoTopView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoTopView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
        ])
    }
    
    func setupEmptyTodoView() {
        emptyTodoLabel.text = TextConstant.emptyLabelText
        emptyTodoLabel.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)
        emptyTodoLabel.textAlignment = .center
        emptyTodoLabel.textColor = #colorLiteral(red: 0.2929826677, green: 0.1407194802, blue: 0.1434625629, alpha: 1)
        emptyTodoLabel.translatesAutoresizingMaskIntoConstraints = false
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

