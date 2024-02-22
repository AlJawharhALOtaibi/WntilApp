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
    
    
    

    func addHistory(date: Date, stepCount: Int, calorieCount: Int, context:NSManagedObjectContext) {
        
        let history = HistoryItem(context: context)
        history.date = date
        history.stepCount = Int64(stepCount)
        history.calorieCount = Int64(calorieCount)
       // history.image = Data(image)

        
        save(context: context)
    }
    
    
    func fetchTotalStepsPerDay() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryItem")
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = "totalSteps"
        expressionDescription.expression = NSExpression(forKeyPath: "stepCount")
        expressionDescription.expressionResultType = .integer32AttributeType
        
        let dateKeyPath = NSExpression(forKeyPath: "date")
        let dateExpression = NSExpression(forFunction: "day:from:", arguments: [expressionDescription, dateKeyPath])
        
        let totalStepsExpression = NSExpressionDescription()
        totalStepsExpression.name = "totalStepsPerDay"
        totalStepsExpression.expression = dateExpression
        totalStepsExpression.expressionResultType = .integer32AttributeType
        
        request.propertiesToFetch = [totalStepsExpression]
        request.propertiesToGroupBy = ["date"]
        request.resultType = .dictionaryResultType
        
        do {
            let results = try container.viewContext.fetch(request)
            for result in results as! [NSDictionary] {
                if let totalSteps = result["totalStepsPerDay"] as? Int32 {
                    // Store the total steps for each day in your model or ViewModel
                    print("Total Steps for Day: \(totalSteps)")
                }
            }
        } catch {
            print("Error fetching total steps: \(error.localizedDescription)")
        }
    }
    
}
