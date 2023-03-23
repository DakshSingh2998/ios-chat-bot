//
//  temp.swift
//  Chat
//
//  Created by Daksh on 23/03/23.
//

import Foundation
import SwiftUI

struct Temp{
    init(){
        
        DatabaseHelper.shared.saveOption(text: "root")
        DatabaseHelper.shared.saveOption(text: "1", parent: "root")
        DatabaseHelper.shared.saveOption(text: "2", parent: "root")
        DatabaseHelper.shared.saveOption(text: "3", parent: "root")
        
        DatabaseHelper.shared.saveOption(text: "4", parent: "1")
        DatabaseHelper.shared.saveOption(text: "5", parent: "1")
        DatabaseHelper.shared.saveOption(text: "6", parent: "1")
        
        DatabaseHelper.shared.saveOption(text: "7", parent: "2")
        DatabaseHelper.shared.saveOption(text: "8", parent: "2")
        DatabaseHelper.shared.saveOption(text: "9", parent: "3")
         
    }
}
