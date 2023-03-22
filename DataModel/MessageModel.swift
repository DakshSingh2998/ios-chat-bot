//
//  MessageModel.swift
//  Chat
//
//  Created by Daksh on 22/03/23.
//

import Foundation
class MessageModel{
    var id = 0
    var sender:[String:Any] = [:]
    var created = ""
    var attachments:[Any] = []
    var sender_username = ""
    var text = ""
    var custom_json:[String:Any] = [:]
    init(id: Int = 0, created: String = "", attachments: [Any], sender_username: String = "", text: String = "", custom_json: [String : Any]) {
        self.id = id
        self.created = created
        self.attachments = attachments
        self.sender_username = sender_username
        self.text = text
        self.custom_json = custom_json
    }
    init(data:[String:Any]){
        if let id = data["id"] as? Int{
            self.id = id
        }
        if let sender = data["sender"] as? [String:Any]{
            self.sender = sender
        }
        if let created = data["created"] as? String{
            self.created = created
        }
        if let attachments = data["attachments"] as? [Any]{
            self.attachments = attachments
        }
        if let sender_username = data["sender_username"] as? String{
            self.sender_username = sender_username
        }
        if let text = data["text"] as? String{
            self.text = text
        }
        if let custom_json = data["custom_json"] as? [String:Any]{
            self.custom_json = custom_json
        }
    }
}
