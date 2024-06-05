//
//  SampleEntity+CoreDataProperties.swift
//  MessingWithAppleWatch Watch App
//
//  Created by Fabio Freitas on 05/06/24.
//
//

import Foundation
import CoreData


extension SampleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SampleEntity> {
        var fr = NSFetchRequest<SampleEntity>(entityName: "SampleEntity")
        fr.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fr.fetchLimit = 1
        return fr
    }

    @NSManaged public var date: Date?

}

extension SampleEntity : Identifiable {

}
