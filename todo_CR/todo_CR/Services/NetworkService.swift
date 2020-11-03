//
//  NetworkService.swift
//  todo_CR
//
//  Created by slava bily on 03.11.2020.
//

import Foundation

class NetworkService: ObservableObject {
    
    @Published var todos = Todos_r(items: items)
    
    static var items = [Todo_r]()
    
    static let shared = NetworkService()
    
    let URL_BASE = "http://localhost:3003"
    let URL_ADD_TODO = "/add"
    let URL_DELETE_TODO = "/delete"
    
    let session = URLSession(configuration: .default)
    
    func getTodos(onSuccess: @escaping (Todos_r) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)")!
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    debugPrint("Showing connection error")
                    onError(error.localizedDescription)
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                do {
                    if response.statusCode == 200 {
                        let items =  try JSONDecoder().decode(Todos_r.self, from: data)
                        onSuccess(items)
                    } else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                } catch {
                    print("O'ops")
                    onError(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func addTodo(todo: Todo_r, onSuccess: @escaping (Todos_r) -> Void, onError: @escaping (String) -> Void) {
        let url = URL(string: "\(URL_BASE)\(URL_ADD_TODO)")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body

            let task = session.dataTask(with: request) { (data, response, error) in

                DispatchQueue.main.async {
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        onError("Invalid data or response")
                        return
                    }
                    do {
                        if response.statusCode == 200 {
                            let items = try JSONDecoder().decode(Todos_r.self, from: data)
                            onSuccess(items)
                        } else {
                            let err = try JSONDecoder().decode(APIError.self, from: data)
                            onError(err.message)
                        }
                    } catch {
                        onError(error.localizedDescription)
                    }
                }
            }
            task.resume()

        } catch {
            onError(error.localizedDescription)
        }

    }

    func deleteTodo(todo: Todo_r, onSuccess: @escaping (Todos_r) -> Void, onError: @escaping (String) -> Void) {

        let url = URL(string: "\(URL_BASE)\(URL_DELETE_TODO)")!

        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            let body = try JSONEncoder().encode(todo)
            request.httpBody = body

            let task = session.dataTask(with: request) { (data, response, error) in

                DispatchQueue.main.async {
                    if let error = error {
                        onError(error.localizedDescription)
                        return
                    }
                    guard let data = data, let response = response as? HTTPURLResponse else {
                        onError("Invalid data or response")
                        return
                    }
                    do {
                        if response.statusCode == 200 {
                            let items = try JSONDecoder().decode(Todos_r.self, from: data)
                            onSuccess(items)
                        } else {
                            let err = try JSONDecoder().decode(APIError.self, from: data)
                            onError(err.message)
                        }
                    } catch {
                        onError(error.localizedDescription)
                    }
                }
            }
            task.resume()

        } catch {
            onError(error.localizedDescription)
        }
    }
}

