//
//  AllChats.swift
//  Chat
//
//  Created by Daksh on 21/03/23.
//

import SwiftUI

struct AllChats: View {
    @Binding var ONPAGE:Double
    @Binding var userModel:UserModel?
    @State var gotoOptionsMenu = false
    @State var alertText = ""
    @State var showAlert = false
    @State var allChats:[ChatModel] = []
    @State var chatModel:ChatModel?
    @State var gotoChatMain = false
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                Spacer()
                List(0..<allChats.count, id: \.self){idx in
                    Text("\(allChats[idx].id)").onTapGesture {
                        chatModel = allChats[idx]
                        gotoChatMain = true
                    }
                }
                NavigationLink("OptionsMenu", destination: OptionsMenu(ONPAGE: $ONPAGE, userModel: $userModel), isActive: $gotoOptionsMenu)
                    .hidden()
                NavigationLink("ChatMain", destination: ChatMain(ONPAGE: $ONPAGE, userModel: $userModel, chatModel: $chatModel, agentName:
                                                                    ((chatModel?.people[0]["person"]) as? [String:Any])? ["username"] as? String), isActive: $gotoChatMain).hidden()
            
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 64)
            
                Text("+")
                    .font(Font(CTFont(.system, size: 32))).bold()
                    .foregroundColor(Color("White"))
                    .padding(32)
                    .background(Color("Orange"))
                    .clipShape(Circle())
                    .padding(.trailing, 16)
                    .onTapGesture {
                        gotoOptionsMenu = true
                    }
            
                    
        }.alert(alertText, isPresented: $showAlert, actions: {
            Button("OK", role: .cancel, action: {
                showAlert = false
            })
        })
        
        .onAppear(){
            var userName = UserDefaults.standard.value(forKey: "user") as! String
            var pass = UserDefaults.standard.value(forKey: "pass") as! String
            ChatApi.shared.getChats(userName: userName, pass: pass, completition: {data, error in
                guard let data = data as? [[String: Any]] else {
                    alertText = (error as! Error).localizedDescription
                    showAlert = true
                    return
                }
                allChats = data.map{
                    ChatModel(data: $0)
                }
                
                
            })
        }
        .navigationTitle("Chats")

    }
}
