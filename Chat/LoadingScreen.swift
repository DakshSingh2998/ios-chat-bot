//
//  LoadingScreen.swift
//  Final
//
//  Created by Daksh on 06/03/35.
//

import SwiftUI

struct LoadingScreen: View {
    @State var ONPAGE:Double = 0.0
    var body: some View{
        ZStack{
            if(ONPAGE == 0.0){
                ProgressView()
            }
            else{
                SignUp(ONPAGE: $ONPAGE)
            }
        }
        .onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                ONPAGE = 1.0
            })
        }
    }
}
/*
 struct LoadingScreen_Previews: PreviewProvider {
 static var previews: some View {
 LoadingScreen()
 }
 }
 */
