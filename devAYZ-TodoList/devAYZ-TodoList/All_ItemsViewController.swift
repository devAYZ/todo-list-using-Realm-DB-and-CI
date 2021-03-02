//
//  ViewController.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.

import UIKit
import RealmSwift

class All_ItemsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - Instantiate instance of All_Items views
    let viewLists = All_ItemsViews()
    
    public let realm = try! Realm()
    public var completionHandler: ( () -> Void)?
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.592452511, green: 0.5285605736, blue: 0.5285605736, alpha: 1)
        
        viewLists.todoTable.register(UITableViewCell.self,
                                     forCellReuseIdentifier: "cell")
        viewLists.todoTable.delegate = self
        viewLists.todoTable.dataSource = self
        
        viewLists.newTodoField.delegate = self
        
        // Top View
        setupTodoTopView()
        // Down View
        if todoListIsEmpty() {
            setupEmptyTodoView()
        } else {
            setupTodoTableView()
        }
    }
    
}

