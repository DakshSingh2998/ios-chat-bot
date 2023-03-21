//
//  NetworkManager.swift
//  Chat
//
//  Created by Daksh on 20/03/23.
//

import Foundation
import SwiftUI

struct NetworkManager{
    static var shared = NetworkManager()
    
    
    func getApi(url:String, completition: ((Any)->())?){
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField:"Content-Type")
        let session = URLSession.shared
        session.dataTask(with: request){
            data, response, err in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) else{
                print("SERL ERR")
                return
            }
            //print(jsonData)
            completition?(jsonData)
        }.resume()
        
    }
    func createUser(userName:String, firstName:String, lastName:String, password:String, completition: ((Any, Any)->())?, urlTask: ((Any)->())?){
        let parameters = "{\n    \"username\": \"\(userName)\",\n    \"first_name\": \"\(firstName)\",\n    \"last_name\": \"\(lastName)\",\n    \"secret\": \"\(password)\" \n}"
        let postData = parameters.data(using: .utf8)
        print(parameters)
        var request = URLRequest(url: URL(string: "https://api.chatengine.io/users/")!,timeoutInterval: Double.infinity)
        request.addValue(Common.shared.privateKey, forHTTPHeaderField: "PRIVATE-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completition?(data, error)
                return
            }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else{
                print("SERL ERR")
                return
            }
            completition?(jsonData, error)
            
        }
        
        task.resume()
        urlTask?(task)
    }
    
    func getUsers(completition: ((Any) -> ())?){
        var request = URLRequest(url: URL(string: "https://api.chatengine.io/users/")!,timeoutInterval: Double.infinity)
        request.addValue(Common.shared.privateKey, forHTTPHeaderField: "PRIVATE-KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }

            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else{
                print("SERL ERR")
                return
            }
          completition?(jsonData)
        }

        task.resume()
    }
    func getUser(userName:String, pass:String, completition: ((Any) -> ())?){
        var request = URLRequest(url: URL(string: "https://api.chatengine.io/users/me/")!,timeoutInterval: Double.infinity)
        request.addValue(Common.shared.projectId, forHTTPHeaderField: "Project-ID")
        request.addValue(userName, forHTTPHeaderField: "User-Name")
        request.addValue(pass, forHTTPHeaderField: "User-Secret")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else{
                print("SERL ERR")
                return
            }
          completition?(jsonData)
            
        }

        task.resume()
    }
    
    
}
