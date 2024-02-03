//
//  HistoryItem+CoreDataClass.swift
//  Wntil
//
//  Created by Wajd Alhadlaq on 21/07/1445 AH.
//
//
import Foundation
import CoreData

@objc(HistoryItem)
public class HistoryItem1: NSManagedObject {
    @NSManaged public var imageData: NSObject?
    @NSManaged public var stepCount: Int64
    @NSManaged public var calorieCount: Int64
    
}

