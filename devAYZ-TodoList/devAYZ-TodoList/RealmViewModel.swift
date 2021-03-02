//
//  RealmViewModel.swift
//  devAYZ-TodoList
//
//  Created by Ayokunle on 02/03/2021.
//

import Foundation
import UIKit
import RealmSwift

struct RealmViewModel {
    let realm = try! Realm()
    
    let items = [ItemsModel]()
    
}
