//
//  WebSocket.swift
//  Chat
//
//  Created by Daksh on 21/03/23.
//

import Foundation
import SwiftUI
class Websocket: ObservableObject {
    @Published var messages:[MessageModel] = []
    var webSocketTask: URLSessionWebSocketTask?
    @Published var chatModel:ChatModel?
    
    init(){
        
    }
    
    func connect() {
        guard let url = URL(string: "wss://api.chatengine.io/chat/?projectID=\(Common.shared.projectId)&chatID=\(chatModel!.id)&accessKey=\(chatModel!.access_key)") else { return }
        print(url)
        let request = URLRequest(url: url)
        webSocketTask = URLSession.shared.webSocketTask(with: request)
        webSocketTask?.resume()
        receiveMessage()
    }
    
    func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    guard let data = text.data(using: .utf8) else{
                        return
                    }
                    guard let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else{
                        print("SERL ERR")
                        return
                    }
                    print((jsonData as? [String:Any])?["data"] as! [String : Any])
                    self.messages.append(MessageModel(data: (jsonData as? [String:Any])?["data"] as! [String : Any]))
                case .data(let data):
                    // Handle binary data
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else { return }
        webSocketTask?.send(.string(message)) { error in
            
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}





