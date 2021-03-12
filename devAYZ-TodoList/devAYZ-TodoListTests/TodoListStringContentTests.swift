//
//  TodoListContent.swift
//  devAYZ-TodoListTests
//
//  Created by Ayokunle on 10/03/2021.
//

import XCTest
@testable import devAYZ_TodoList

class TodoListStringContentTests: XCTestCase {
    var todoList: ItemsModel!

    override func setUpWithError() throws {
        super.setUp()
        todoList = ItemsModel()
        todoList.todoData = "test1"
    }

    override func tearDownWithError() throws {
        todoList = nil
        super.tearDown()
    }
    
    func testEmptyTodoList () throws {
        
        XCTAssertNotNil(todoList)
    }
 
    func testTodoListStringLength () throws {
        
        XCTAssertGreaterThanOrEqual(todoList.todoData.count, 2)
    }
    
    func testTodoListFirstNotWhiteSpace () throws {
        XCTAssertNotEqual(todoList.todoData.first, " ")
    }

}
