//
//  TodoListItem.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 28/02/2021.
//

import Foundation
import RealmSwift


class TodoListItem: Object {
    
    @objc dynamic static var id: Int = 0
    @objc dynamic var todoData: String = "Done, nice try"//String()
    
    override init() {
        TodoListItem.id += 1
    }

}
