//
//  ChatMain.swift
//  Chat
//
//  Created by Daksh on 22/03/23.
//

import SwiftUI

struct ChatMain: View {
    @Binding var ONPAGE:Double
    @Binding var userModel:UserModel?
    @Binding var chatModel:ChatModel?
    @State var agentName:String?
    @ObservedObject var webSocket = Websocket()
    @State var textInTf = ""
    @State var alertText = ""
    @State var showAlert = false
    var body: some View {
        ZStack{
            VStack{
                List(0..<webSocket.messages.count, id: \.self){ idx in
                    Text(webSocket.messages[idx].text)
                }
                Spacer()
                TextField("Enter :)", text: $textInTf, onCommit: {
                    
                })
                    
            }
        }
        .alert(alertText, isPresented: $showAlert, actions: {
            Button("OK", role: .cancel, action: {
                showAlert = false
            })
        })
        .onAppear(){
            var userName = UserDefaults.standard.value(forKey: "user") as! String
            var pass = UserDefaults.standard.value(forKey: "pass") as! String
            ChatApi.shared.getMessages(userName: userName, pass: pass, chatId: chatModel!.id, completition: {data, error in
                guard let data = data as? [[String: Any]] else {
                    alertText = (error as! Error).localizedDescription
                    showAlert = true
                    return
                }
                webSocket.messages = data.map{
                    MessageModel(data: $0)
                }
                print(data)
                
            })
            webSocket.chatModel = chatModel
            webSocket.connect()
        }
    }
}

/*
struct ChatMain_Previews: PreviewProvider {
    static var previews: some View {
        ChatMain()
    }
}

*/
