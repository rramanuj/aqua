//
//  Water.swift
//  Aqua
//
//  Created by Rasesh Ramanuj on 07/06/2018.
//  Copyright © 2018 Rasesh Ramanuj. All rights reserved.
//

import Foundation
import HealthKit

struct GlobalVar {
    static var defaultMl1 = 250
    static var dailyDrink = 1800.00
}


class Glass {
    var name: String
    var ml: Double
    var drank: Bool
    var healthkitObject: HKObject
    var created = Date()
 

    //TODO: Add ml into constructor
    init()
    {
        self.ml = 0 //300ml glass by default
        self.drank = false
        self.name = "Glass"
        self.healthkitObject = HKQuantitySample(type: HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)! ,
                                                quantity: HKQuantity(unit: HKUnit.liter(), doubleValue: ml)
            , start: created, end: created)
    }
}

//represents an array of Task instances for global storage.
class Glasses {
    //initializes an array of glasses.
    var glasses:[Glass]
    
    public static let glassArray = Glasses()
    //allows outside data members to access our task array.
    private init() {
        self.glasses = []
    }
    
    
    //Adds a default cup of water
    public func addCup() throws {
        self.glasses.append(Glass())
    }
    
    /*
     //adds a task object
     public func addExistingTask(t: Task) throws {
     self.tasks.append(t)
     }
     public func getCompletedTasks() -> Array<Task> {
     return self.tasks.filter{$0.completed == false}
     }
     //removes all tasks within the array.
     public func deleteAllInstances() {
     self.tasks.removeAll()
     }*/
    
}
