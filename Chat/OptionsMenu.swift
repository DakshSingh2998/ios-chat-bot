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
    var body: some View {
        ZStack{
            Text("Talk to Customer Care").onTapGesture {
                createChat()
            }
            NavigationLink("ChatMain", destination: ChatMain(ONPAGE: $ONPAGE, userModel: $userModel, chatModel: $chatModel), isActive: $gotoChatMain).hidden()
        }
        
    }
    func createChat(){
        var userName = UserDefaults.standard.value(forKey: "user") as! String
        var pass = UserDefaults.standard.value(forKey: "pass") as! String
        ChatApi.shared.createChat(userName: userName, pass: pass, completition: {data, error in
            guard let data = data as? [String: Any] else {
                return
            }
            chatModel = ChatModel(data: data)
            print(chatModel)
            gotoChatMain = true
            
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
