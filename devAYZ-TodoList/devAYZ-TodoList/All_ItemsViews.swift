//
//  TodoListViews.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.
//

import UIKit

class All_ItemsViews: UIView {
    
    var todoTopView: UIView = {
        let todoTopView = UIView()
        todoTopView.backgroundColor = #colorLiteral(red: 0.8767417073, green: 0.782191131, blue: 0.782191131, alpha: 1)
        todoTopView.translatesAutoresizingMaskIntoConstraints = false
        return todoTopView
    } ()
    
    
    lazy var newTodoField: UITextField = {
        let newTodoField = UITextField()
        newTodoField.translatesAutoresizingMaskIntoConstraints = false
        newTodoField.backgroundColor = #colorLiteral(red: 0.8979414105, green: 0.8980956078, blue: 0.8979316354, alpha: 1)
        newTodoField.layer.borderWidth = 0.5
        newTodoField.layer.borderColor = #colorLiteral(red: 0.4175926438, green: 0.2472064052, blue: 0.2500320288, alpha: 1)
        newTodoField.layer.cornerRadius = 4
        return newTodoField
    }()
    
    lazy var addNewTodoBtn: UIButton = {
        let addNewTodoBtn = UIButton(type: .system)
        addNewTodoBtn.translatesAutoresizingMaskIntoConstraints = false
        addNewTodoBtn.setTitle("Add Item", for: .normal)
        addNewTodoBtn.backgroundColor = #colorLiteral(red: 0.2929826677, green: 0.1407194802, blue: 0.1434625629, alpha: 1)
        addNewTodoBtn.layer.cornerRadius = 4
        addNewTodoBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        addNewTodoBtn.setTitleColor(.white, for: .normal)
        return addNewTodoBtn
    }()
    
    lazy var emptyTodoLabel: UITextView = {
        let emptyTodoLabel = UITextView()
        emptyTodoLabel.text = TextConstant.emptyLabelText
        emptyTodoLabel.font = UIFont(name: "Apple SD Gothic Neo Bold", size: 40)
        emptyTodoLabel.textAlignment = .center
        emptyTodoLabel.textColor = #colorLiteral(red: 0.2929826677, green: 0.1407194802, blue: 0.1434625629, alpha: 1)
        emptyTodoLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyTodoLabel.isEditable = false
        emptyTodoLabel.isSelectable = false
        return emptyTodoLabel
    } ()
    
    lazy var todoTable: UITableView = {
        let todoTable = UITableView()
        todoTable.translatesAutoresizingMaskIntoConstraints = false
        return todoTable
    } ()
    
    lazy var emptyListAlert: UIAlertController = {
        let emptyListAlert = UIAlertController(title: "Empty Item",
                                               message: "You cannot add an empty item",
                                               preferredStyle: .alert)
        let emptyListAlertAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
        emptyListAlert.addAction(emptyListAlertAction)
        return emptyListAlert
    }()
    
    lazy var errorListLengthAlert: UIAlertController = {
        let errorListLengthAlert = UIAlertController(title: "Less Character",
                                                     message: "You cannot add one characters",
                                                     preferredStyle: .alert)
        let errorListLengthAlertAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
        errorListLengthAlert.addAction(errorListLengthAlertAction)
        return errorListLengthAlert
    }()
    
    lazy var errorFirstCharacterAlert: UIAlertController = {
        let errorFirstCharacterAlert = UIAlertController(title: "Error First Character",
                                                         message: "You cannot add whitespace as first character",
                                                         preferredStyle: .alert)
        let errorFirstCharacterAlertAction = UIAlertAction(title: "Go Back", style: .cancel, handler: nil)
        errorFirstCharacterAlert.addAction(errorFirstCharacterAlertAction)
        return errorFirstCharacterAlert
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
