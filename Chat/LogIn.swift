//
//  LoginPage.swift
//  Final
//
//  Created by Daksh on 16/02/23.
//

import SwiftUI

struct LogIn: View {
    @Environment(\.dismiss) var dismiss
    @Binding var ONPAGE:Double
    @ObservedObject var vmUserName = TextModel()
    @ObservedObject var vmPass = TextModel()
    @FocusState var userNameFocus:Bool
    @FocusState var passFocus:Bool
    @State var width = Common.shared.width
    @State var tfWidth = Common.shared.width - 100
    @State var height = Common.shared.height
    @State var temp = ""
    @State var isPassIncorrect = false
    @State var isUserNameIncorrect = false
    @State var CustomNavitaionTitle = "Log In"
    @State var readyToNavigate : Bool = false
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: -8){
                    Image(uiImage: UIImage(named: "Rapipay_SignUp")!).resizable()
                        .frame(width: 250, height: 200)
                        .scaledToFill()
                        .padding(.vertical, -32)
                    CustomTextField(defaultplaceholder: "User Name", vm: vmUserName, width: $tfWidth, isInCorrect: $isUserNameIncorrect, commitClosure: {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                            passFocus = true
                        })
                    }).focused($userNameFocus).onTapGesture {
                        isUserNameIncorrect = false
                    }
                    CustomTextField(defaultplaceholder: "Password", vm: vmPass, width: $tfWidth, isProtected: true, isInCorrect: $isPassIncorrect, commitClosure: {
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2, execute: {
                            userNameFocus = true
                        })
                    }).focused($passFocus).onTapGesture {
                        isPassIncorrect = false
                    }
                    CustomPrimaryButton(title: "Sign in"){
                        
                        isPassIncorrect = false
                        isUserNameIncorrect = false
                        userNameFocus = false
                        passFocus = false
                        getUsers()
                        
                    }.padding(.top, 32)
                    
                    CustomPrimaryButton(title: "Create Account"){
                        readyToNavigate = true
                        
                    }.padding(.top, 32)
                    
                    
                }.padding(.horizontal, 50)
                    .onAppear(){
                        print("ONPAGE3 \(ONPAGE)")
                        self.width = Common.shared.width
                        self.tfWidth = Common.shared.width - 100
                        self.height = Common.shared.height
                        userNameFocus = true
                        
                    }
                    .onDisappear(){
                        vmUserName.value = ""
                        vmPass.value = ""
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                        DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                            self.width = Common.shared.width
                            self.tfWidth = Common.shared.width - 100
                            self.height = Common.shared.height
                        }
                    }
                    .frame(minHeight: self.height - self.height/3)
                    //.navigationBarHidden(true)
            }
            .padding(.top, 80)
        }
        .navigationTitle("LogIn")
        .navigationDestination(isPresented: $readyToNavigate) {
            SignUp(ONPAGE: $ONPAGE)
        }
        //.overlay(CustomNavigation(title: $CustomNavitaionTitle, ONPAGE: $ONPAGE, rightImage: ""))
            .onChange(of: ONPAGE){newVal in
                if(ONPAGE < 3.0){
                    try? dismiss()
                }
            }
            .onAppear(){
                
            }
    }
    
    func getUsers(){
        NetworkManager.shared.getUsers(completition: { data in
            print(String(data: data as! Data, encoding: .utf8)!)
            
        })
    }
}
/*
 struct LoginPage_Previews: PreviewProvider {
 static var previews: some View {
 LoginPage()
 }
 }
 */
