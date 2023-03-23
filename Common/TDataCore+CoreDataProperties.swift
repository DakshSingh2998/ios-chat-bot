//
//  TDataCore+CoreDataProperties.swift
//  Chat
//
//  Created by Daksh on 23/03/23.
//
//

import Foundation
import CoreData


extension TDataCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TDataCore> {
        return NSFetchRequest<TDataCore>(entityName: "TDataCore")
    }

    @NSManaged public var text: String?
    @NSManaged public var toMany: NSSet?
    @NSManaged public var toOne: TDataCore?

}

// MARK: Generated accessors for toMany
extension TDataCore {

    @objc(addToManyObject:)
    @NSManaged public func addToToMany(_ value: TDataCore)

    @objc(removeToManyObject:)
    @NSManaged public func removeFromToMany(_ value: TDataCore)

    @objc(addToMany:)
    @NSManaged public func addToToMany(_ values: NSSet)

    @objc(removeToMany:)
    @NSManaged public func removeFromToMany(_ values: NSSet)

}

extension TDataCore : Identifiable {

}
