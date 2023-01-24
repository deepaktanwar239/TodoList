//
//  ViewController.swift
//  TodoList
//
//  Created by Deepak Tanwar on 27/12/22.
//

import UIKit

class ViewController: UIViewController {
    var todos = [
        Todo(title: "This is todo list 1"),
        Todo(title: "This is todo list 2"),
        Todo(title: "This is todo list 3")
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    @IBSegueAction func todoView(_ coder: NSCoder) -> TodoViewController? {
        let vc = TodoViewController(coder: coder)
        if let index = tableView.indexPathForSelectedRow{
            let todo = todos[index.row]
            vc?.todo = todo
        }
        vc?.delegate = self
        vc?.presentationController?.delegate = self
        return vc
    }
   
    
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
            let todo = self.todos[indexPath.row].completeToggled()
            self.todos[indexPath.row] = todo
            let cell = tableView.cellForRow(at: indexPath) as! CheckboxTableViewCell
            cell.setChekbox(checked: todo.isComplete)
            complete(true)
            
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ViewController : UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxTableViewCell") as! CheckboxTableViewCell
        let todo =  todos[indexPath.row]
        cell.delegate = self
        cell.set(title: todo.title, checkBox: todo.isComplete)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath .row)
        todos.insert(todo, at: destinationIndexPath.row)
    }
    
    
}
extension ViewController : CheckboxTableViewCellDelegate {
    func checkTableViewCell(_ cell: CheckboxTableViewCell, didChangeCheckState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else{return}
        let todo = todos[indexPath .row]
        let newTodo = Todo(title: todo.title, isComplete: todo.isComplete)
        todos[indexPath.row] = newTodo
    }
    
    
}

extension ViewController : TodoViewControllerDelegate {
    func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo) {
        
        dismiss(animated: true){
            if let indexPath = self.tableView.indexPathForSelectedRow {
                self.todos[indexPath.row] = todo
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }else{
                self.todos.append(todo)
                self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1, section: 0)], with: .automatic)
            }
        }
    }
    
    
}

extension ViewController : UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
