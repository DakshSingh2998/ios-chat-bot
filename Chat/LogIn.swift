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
    @State var gotoSignUp : Bool = false
    @State var userModel:UserModel?
    @State var signUp:SignUp?
    @State var commonAlert = ""
    @State var showCommonAlert = false
    @State var allChats:AllChats?
    @State var gotoAllChats = false
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
                        print(vmPass.value)
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
                        getUser()
                        
                    }.padding(.top, 32)
                    
                    CustomPrimaryButton(title: "Create Account"){
                        gotoSignUp = true
                        
                    }.padding(.top, 32)
                    NavigationLink("SignUp", destination: signUp, isActive: $gotoSignUp).hidden()
                    NavigationLink("AllChats", destination: allChats, isActive: $gotoAllChats).hidden()

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
                        isUserNameIncorrect = false
                        isPassIncorrect = false
                        
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
        
        //.overlay(CustomNavigation(title: $CustomNavitaionTitle, ONPAGE: $ONPAGE, rightImage: ""))
            
            .onAppear(){
                signUp = SignUp(ONPAGE: $ONPAGE)
                allChats = AllChats(ONPAGE: $ONPAGE, userModel: $userModel)
                vmUserName.value = "daksh2998"
                vmPass.value = "Daksh@90"
            }
            .alert(commonAlert, isPresented: $showCommonAlert, actions: {
                Button("OK", role: .cancel, action: {
                    showCommonAlert = false
                })
            })
    }
    
    func getUser(){
        NetworkManager.shared.getUser(userName: vmUserName.value, pass: vmPass.value, completition: { data, error in
            guard let data = data as? [String: Any] else {
                commonAlert = "\((error as! Error).localizedDescription)"
                showCommonAlert = true
                return
            }
            if(data["detail"] != nil){
                isUserNameIncorrect = true
                isPassIncorrect = true
                return
            }
            userModel = nil
            self.userModel = UserModel(data: data)
            print(self.userModel)
            gotoAllChats = true
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
