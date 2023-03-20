//
//  SignUp.swift
//  Chat
//
//  Created by Daksh on 20/03/23.
//

import SwiftUI
import CoreData


class TextModel:ObservableObject{
    @Published var value = ""
    
}

struct SignUp: View {
    @Environment(\.dismiss) var dismiss
    @Binding var ONPAGE:Double
    @ObservedObject var vmUserName = TextModel()
    @ObservedObject var vmFirstName = TextModel()
    @ObservedObject var vmLastName = TextModel()
    @ObservedObject var vmPassword = TextModel()
    @FocusState var userNameFocus:Bool
    @FocusState var firstNameFocus:Bool
    @FocusState var lastNameFocus:Bool
    @FocusState var passwordFocus:Bool
    @State var height = Common.shared.height
    @State var temp = ""
    @State var width = Common.shared.width
    @State var tfWidth = Common.shared.width - 100
    //@State var loginPage:LoginPage?
    //@State var gotoLogin = false
    @State var isUserNameIncorrect = false
    @State var isFirstNameIncorrect = false
    @State var isLastNameIncorrect = false
    @State var isPasswordIncorrect = false
    @State var False = false
    @State var successfulSignup = false
    @State var alertText = ""
    @State var CustomNavitaionTitle = "Sign Up"
    var coloredSignIn: AttributedString{
        var result = AttributedString("Sign In")
        result.foregroundColor = Color("Blue")
        result.font = .boldSystemFont(ofSize: 16)
        return result
    }
    
    
    var body: some View {
        ZStack(alignment: .top){
            ScrollView{
                
                
                VStack(spacing: -8){
                    
                    Image(uiImage: UIImage(named: "Rapipay_SignUp")!).resizable()
                        .frame(width: 250, height: 200)
                        .scaledToFill()
                    
                        .padding(.bottom, 32)
                    CustomTextField(defaultplaceholder: "User Name", vm: vmUserName, width: $tfWidth, isInCorrect: $isUserNameIncorrect, commitClosure: {
                        if(Common.shared.isValidName(vmUserName.value) == false){
                            isUserNameIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                userNameFocus = true
                            }
                            return
                        }
                        else{
                            isUserNameIncorrect = false
                        }
                        isFirstNameIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            firstNameFocus = true
                        }
                    }).focused($userNameFocus).onTapGesture {
                        isUserNameIncorrect = false
                    }
                    CustomTextField(defaultplaceholder: "First Name", vm: vmFirstName, width: $tfWidth, isInCorrect: $isFirstNameIncorrect, commitClosure: {
                        if(Common.shared.isValidName(vmFirstName.value) == false){
                            isFirstNameIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                firstNameFocus = true
                            }
                            return
                        }
                        else{
                            isFirstNameIncorrect = false
                        }
                        isLastNameIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            lastNameFocus = true
                        }
                    }).focused($firstNameFocus).onTapGesture {
                        isFirstNameIncorrect = false
                    }
                    CustomTextField(defaultplaceholder: "Last Name", vm: vmLastName, width: $tfWidth, isInCorrect: $isLastNameIncorrect, commitClosure: {
                        if(Common.shared.isValidName(vmLastName.value) == false){
                            isLastNameIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                lastNameFocus = true
                            }
                            return
                        }
                        else{
                            isLastNameIncorrect = false
                        }
                        isPasswordIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            passwordFocus = true
                        }
                    }).focused($lastNameFocus).onTapGesture {
                        isLastNameIncorrect = false
                    }
                    
                    CustomTextField(defaultplaceholder: "Password", vm: vmPassword, width: $tfWidth, isProtected: true, isInCorrect: $isLastNameIncorrect, commitClosure: {
                        if(Common.shared.isValidPassword(vmPassword.value) == false){
                            isPasswordIncorrect = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                                passwordFocus = true
                            }
                            return
                        }
                        else{
                            isPasswordIncorrect = false
                        }
                        isUserNameIncorrect = false
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.2){
                            userNameFocus = true
                        }
                    }).focused($passwordFocus).onTapGesture {
                        isPasswordIncorrect = false
                    }
                    
                    
                    CustomPrimaryButton(title: "Sign up"){
                        //print(vmUserName.value)
                        createUser()
                        
                        print("data saved")
                        alertText = "Successful Sign Up"
                        successfulSignup = true
                        //print(DatabaseHelper.shared.loadUsers())
                    }.alert(alertText, isPresented: $successfulSignup, actions: {
                        
                    }).onChange(of: successfulSignup, perform: { newVal in
                        if(successfulSignup == false){
                            ONPAGE = 3.0
                            //gotoLogin = true
                        }
                    })
                    .padding(.top, 32)
                    
                }
                .padding(.horizontal, 50)
                .frame(minHeight: self.height - self.height/5)
                
                .onAppear(){
                    print("ONPAGE2 \(ONPAGE)")
                    /*
                    CustomTextField.sendFocus = {received in
                        if(received == "Name"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                emailFocus = true
                            }
                        }
                        if(received == "Email"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                passFocus = true
                            }
                        }
                        if(received == "Password"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                dobFocus = true
                            }
                        }
                        if(received == "Date of Birth"){
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                                nameFocus = true
                            }
                        }
                    }
                    self.width = Common.shared.width
                    self.height = Common.shared.height
                    self.tfWidth = Common.shared.width - 100
                    nameFocus = true
                    */
                }
                .onDisappear(){
                    vmUserName.value = ""
                    vmFirstName.value = ""
                    vmLastName.value = ""
                    vmPassword.value = ""
                }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)){_ in
                    //Global.shared.updateOrientation()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.8){
                        self.width = Common.shared.width
                        self.tfWidth = Common.shared.width - 100
                        self.height = Common.shared.height
                        print(self.width)
                    }
                    
                }
                
            }
            .navigationBarHidden(true)
            .padding(.top, 40)
        }
        //.overlay(CustomNavigation(title: $CustomNavitaionTitle, ONPAGE: $ONPAGE, rightImage: ""))
        .onAppear(){
            vmUserName.value = "daksh2998"
            vmFirstName.value = "Daksh"
            vmLastName.value = "Singh"
            vmPassword.value = "DakshSingh@9090"
        }
        
        .onChange(of: ONPAGE){newVal in
            if(ONPAGE < 2.0){
                try? dismiss()
            }
        }
    }
    func createUser(){
        NetworkManager.shared.createUser(userName: vmUserName.value, firstName: vmFirstName.value, lastName: vmLastName.value, password: vmPassword.value){data in
            print(String(data: data as! Data, encoding: .utf8)!)
            
        }
    }
}
extension View{
    @ViewBuilder func isHidden(_ hide:Bool) -> some View {
        if hide{
            self.hidden()
        }
        else{
            self
        }
    }
}
