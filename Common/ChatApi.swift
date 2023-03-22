//
//  ChatApi.swift
//  Chat
//
//  Created by Daksh on 22/03/23.
//

import Foundation
class ChatApi{
    static var shared = ChatApi()
    
    func createChat(userName:String, pass:String, completition: ((Any, Any) -> ())?){
        let url = "https://api.chatengine.io/chats/"
        let parameters = "{\n    \"title\": \"\(UUID())\",\n    \"is_direct_chat\": false\n}"
        let httpMethod = "POST"
        let addValue = ["Project-ID" : Common.shared.projectId, "User-Name" : userName, "User-Secret" : pass]
        let setValue = ["Content-Type" : "application/json", "Accept" : "application/json"]
        NetworkManager.shared.connect(parameters: parameters, url: url, httpMethod: httpMethod, setValue: setValue, addValue: addValue, completition: {data, error in
            completition?(data, error)
            
        })
        
        
    }
    
}
