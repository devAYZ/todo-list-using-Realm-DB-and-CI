//
//  ViewController.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.
//

import UIKit
import RealmSwift

class TodoListViewController: UIViewController {
    
    var items = [TodoListItem]()
    
    let todoTopView = UIView()
    let emptyItemLabel = UITextView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.8767417073, green: 0.782191131, blue: 0.782191131, alpha: 1)
        

        items.append(TodoListItem())
        items.append(TodoListItem())
        
        debugPrint(TodoListItem.id)
        debugPrint(items.count)
        
        setupTodoTopView()
        setupEmptyItemBottomView()
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
    
    func setupEmptyItemBottomView() {
        emptyItemLabel.text = TextConstant.emptyLabelText
        emptyItemLabel.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)
        emptyItemLabel.textAlignment = .center
        emptyItemLabel.textColor = #colorLiteral(red: 0.2929826677, green: 0.1407194802, blue: 0.1434625629, alpha: 1)
        emptyItemLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyItemLabel)
        
        NSLayoutConstraint.activate([
            emptyItemLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyItemLabel.topAnchor.constraint(equalTo: todoTopView.bottomAnchor),
            emptyItemLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyItemLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            emptyItemLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9),
            
        ])
    }


}

