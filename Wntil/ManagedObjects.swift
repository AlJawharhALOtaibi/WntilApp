//
//  ManagedObjects.swift
//  Wntil
//
//  Created by Wajd Alhadlaq on 21/07/1445 AH.
//

import Foundation
import CoreData

class CapturedImage: NSManagedObject {
    @NSManaged var imageData: Data?
    // Add other attributes as needed
}

class StepCount: NSManagedObject {
    @NSManaged var count: Int
    // Add other attributes as needed
}

class CalorieCount: NSManagedObject {
    @NSManaged var count: Int
    // Add other attributes as needed
}
