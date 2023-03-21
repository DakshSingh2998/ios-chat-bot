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
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 64)
            
                Text("+")
                    .font(Font(CTFont(.system, size: 32))).bold()
                    .foregroundColor(Color("White"))
                    .padding(32)
                    .background(Color("Orange"))
                    .clipShape(Circle())
                    
        }
        .navigationTitle("Chats")

    }
}
