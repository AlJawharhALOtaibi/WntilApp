//
//  SwiftData.swift
//  Wntil
//
//  Created by Wajd Alhadlaq on 23/07/1445 AH.
//

import Foundation
import SwiftData

class History: SDRecord, Codable {
    @objc var id = 0
    var date = Date()
    var stepCount = 0
    var calorieCount = 0
    var capturedImageData: Data? // Binary Data to store the image

    override func primaryKey() -> String {
        return "id"
    }
}
