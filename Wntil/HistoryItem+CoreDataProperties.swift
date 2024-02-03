//
//  HistoryItem+CoreDataProperties.swift
//  Wntil
//
//  Created by Wajd Alhadlaq on 21/07/1445 AH.
//
//

import Foundation
import CoreData


extension HistoryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryItem> {
        return NSFetchRequest<HistoryItem>(entityName: "HistoryItem")
    }

    @NSManaged public var calorieCount: Int64
    @NSManaged public var capturedImage: Data?
    @NSManaged public var stepCount: Int64

}

extension HistoryItem : Identifiable {

}
