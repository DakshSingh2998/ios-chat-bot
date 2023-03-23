//
//  DatabaseHelper.swift
//  First
//
//  Created by Daksh on 09/02/23.
//

import CoreData
import UIKit
import Foundation
import SwiftUI
struct DatabaseHelper{
    //@Environment(\.managedObjectContext) var context
    var context = PersistenceController.shared.container.viewContext
    static var shared = DatabaseHelper()
    func saveOption(text:String, parent:String? = nil){
        let obj = NSEntityDescription.insertNewObject(forEntityName: "TDataCore", into: context) as! TDataCore
        obj.text = text
        if(parent != nil){
            var objs = DatabaseHelper.shared.loadOptions()
            var idx:TDataCore? = nil
            for i in objs{
                if(i.text == parent){
                    idx = i
                    break
                }
            }
            obj.toOne = idx
            idx?.addToToMany(obj)
            
        }
        do{
            try? context.save()
        }
        catch{
            print("Error in saving")
        }
    }
    func loadOptions() -> [TDataCore]{
        var obj:[TDataCore] = []
        //let fetchreq = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do{
            obj = try context.fetch(NSFetchRequest(entityName: "TDataCore")) as! [TDataCore]
            for i in obj{
                print(i.text!, "tomany")
                for j in i.toMany!{
                    print((j as! TDataCore).text)
                }
                print("toone", i.toOne != nil ? i.toOne?.text : "")
            }
            
        }
        catch{
            print("Error in loading")
        }
        return obj
    }
}

