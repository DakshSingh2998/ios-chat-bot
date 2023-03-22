//
//  OptionsMenu.swift
//  Chat
//
//  Created by Daksh on 22/03/23.
//

import SwiftUI

struct OptionsMenu: View {
    @Binding var ONPAGE: Double
    @Binding var userModel:UserModel?
    @State var gotoChatMain = false
    @State var chatModel:ChatModel?
    @State var alertText = ""
    @State var showAlert = false
    @State var randAgent:UserModel?
    var body: some View {
        ZStack{
            VStack{
                Text("Talk to Customer Care").onTapGesture {
                    createChat()
                }
                NavigationLink("ChatMain", destination: ChatMain(ONPAGE: $ONPAGE, userModel: $userModel, chatModel: $chatModel, agentName: randAgent?.userName), isActive: $gotoChatMain).hidden()
            }
        }
        .alert(alertText, isPresented: $showAlert, actions: {
            Button("OK", role: .cancel, action: {
                showAlert = false
            })
        })
    }
    func createChat(){
        var userName = UserDefaults.standard.value(forKey: "user") as! String
        var pass = UserDefaults.standard.value(forKey: "pass") as! String
        
        var dg = DispatchGroup()
        var completed = 0
        dg.enter()
        ChatApi.shared.createChat(userName: userName, pass: pass, completition: {data, error in
            guard let data = data as? [String: Any] else {
                alertText = (error as! Error).localizedDescription
                showAlert = true
                dg.leave()
                return
            }
            chatModel = ChatModel(data: data)
            print(chatModel)
            completed = completed + 1
            dg.leave()
            
            //gotoChatMain = true
        })
        dg.enter()
        UserApi.shared.getUsers(completition: {data, error in
            guard let data = data as? [[String:Any]] else{
                dg.leave()
                return
            }
            var usersModel = data.map{UserModel(data: $0)}
            var agents:[UserModel] = []
               for i in usersModel{
                   if(i.email.starts(with: "agent")){
                       agents.append(i)
                   }
               }
               let randomAgent = Int.random(in: 0..<agents.count)
            randAgent = usersModel[randomAgent]
            
            completed = completed + 1

            dg.leave()
        })
        dg.notify(queue: DispatchQueue.global(qos: .utility), execute: {
            if(completed == 2){
                ChatApi.shared.addMember(chatId: chatModel!.id, userName: userName, pass: pass, userModelToAdd: randAgent!.userName, completition: {data, error in
                    guard let data = data as? [String: Any] else {
                        alertText = (error as! Error).localizedDescription
                        showAlert = true
                        return
                    }
                    print(data)
                    gotoChatMain = true
                })
                
            }
        })
    }
}

/*
struct OptionsMenu_Previews: PreviewProvider {
    static var previews: some View {
        OptionsMenu()
    }
}
*/
