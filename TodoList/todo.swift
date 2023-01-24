//
//  todo.swift
//  TodoList
//
//  Created by Deepak Tanwar on 27/12/22.
//

import Foundation

struct Todo {
    let title : String
    let isComplete : Bool 
    init(title: String, isComplete : Bool = false) {
        self.title = title
        self.isComplete = isComplete
    }
    
    func completeToggled() -> Todo {
        return Todo(title: title, isComplete: !isComplete)
    }
}
