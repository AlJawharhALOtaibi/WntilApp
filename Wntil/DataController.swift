//
//  DataController.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 12/07/1445 AH.
//

import CoreData
import Foundation

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "Wntil")
    
    init(){
        container.loadPersistentStores{ description, error in if let  error = error {
            print("Core Data failed to load: \(error.localizedDescription)")
            
            
        }}
        
        
    }
    
    
}
