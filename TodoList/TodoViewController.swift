//
//  TodoViewController.swift
//  TodoList
//
//  Created by Deepak Tanwar on 27/12/22.
//

import UIKit

protocol TodoViewControllerDelegate : AnyObject {
    func todoViewController(_ vc : TodoViewController, didSaveTodo : Todo)
}

class TodoViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var todo : Todo?
    weak var delegate : TodoViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = todo?.title
    }
    

    @IBAction func save(_ sender: Any) {
        print(textField.text!)
        let todo = Todo(title: textField.text!)
        delegate?.todoViewController(self, didSaveTodo : todo)
    }
    

}
