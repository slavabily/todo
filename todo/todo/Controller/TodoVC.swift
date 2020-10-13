//
//  ViewController.swift
//  todo
//
//  Created by slava bily on 04.10.2020.
//

import UIKit

class TodoVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var todoItemTxt: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var todoTable: UITableView!
    
    var todos = Array<Todo>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoTable.delegate = self
        todoTable.dataSource = self
        
        getTodos()
        
        //for test purpose
        NetworkService.shared.deleteTodo(todo: Todo(item: "Take out trash", priority: 0, index: 0)) { (todos) in
            self.todos = todos.items
            self.todoTable.reloadData()
        } onError: { (errorMessage) in
            //show any errors to user on DELETE
            debugPrint(errorMessage)
        }

    }
    
    func getTodos() {
        NetworkService.shared.getTodos { (todos) in
            self.todos = todos.items
            self.todoTable.reloadData()
        } onError: { (errorMessage) in
            //show alert to user
            debugPrint(errorMessage)
        }

    }
    
    
    func deleteTodo(at index: Int) {
         
         
    }
    

    @IBAction func addTodo(_ sender: Any) {
        
        guard let todoItem = todoItemTxt.text else {
            //show error "you must enter todo item"
            return
        }
        let todo = Todo(item: todoItem, priority: prioritySegment.selectedSegmentIndex, index: nil)
        
        NetworkService.shared.addTodo(todo: todo) { (todos) in
            self.todoItemTxt.text = ""
            self.todos = todos.items
            self.todoTable.reloadData()
        } onError: { (errorMessage) in
            //show any errors to user on POST
            debugPrint(errorMessage)
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as? TodoCell {
            cell.updateCell(todo: todos[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //MARK: Deletion
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTodo(at: indexPath.row)
            getTodos()
        }
    }
}

