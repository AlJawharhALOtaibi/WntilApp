//
//  DataController.swift
//  Wntil
//
//  Created by AlJawharh AlOtaibi on 12/07/1445 AH.
//

import CoreData
import Foundation



class DataController: ObservableObject{
    
    let container = NSPersistentContainer(name: "HistoryModel")
    
    init(){
        container.loadPersistentStores{ description, error in if let  error = error {
            print("Core Data failed to load: \(error.localizedDescription)")
            
            
        }
        }
        
        
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data Saved")
        } catch{
            print("We could not save the data")
        }
    }
    
    
    
    func addHistory(date: Date, stepCount: Int, calorieCount: Int, context: NSManagedObjectContext) {
        
        let history = HistoryItem(context: context)
        history.date = date
        // history.capturedImage = imageData as NSObject
        history.stepCount = Int64(stepCount)
        history.calorieCount = Int64(calorieCount)
    
            
            save(context: context)
        }
    }



