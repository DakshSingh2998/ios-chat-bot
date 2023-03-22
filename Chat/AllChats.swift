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
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                Spacer()
                NavigationLink("OptionsMenu", destination: OptionsMenu(ONPAGE: $ONPAGE, userModel: $userModel), isActive: $gotoOptionsMenu)
                    .hidden()
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
            
                    
        }
        .navigationTitle("Chats")

    }
}
