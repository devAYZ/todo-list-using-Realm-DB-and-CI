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
    @objc dynamic var data: String = String()
    
    override init() {
        TodoListItem.id += 1
    }

}
