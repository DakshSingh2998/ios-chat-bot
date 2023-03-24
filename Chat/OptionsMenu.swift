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
                NavigationLink("ChatMain", destination: ChatMain(ONPAGE: $ONPAGE, userModel: $userModel, chatModel: $chatModel), isActive: $gotoChatMain).hidden()
            }
        }
        .alert(alertText, isPresented: $showAlert, actions: {
            Button("OK", role: .cancel, action: {
                showAlert = false
            })
        })
    }
    func createChat(){
        OptionsMenuModel.shared.createChat(userName: Common.shared.userDefaultName, pass: Common.shared.userDefaultPass, completition: {chatModel, error in
            if(error != nil){
                alertText = error!
                showAlert = true
                return
            }
            self.chatModel = chatModel!
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
