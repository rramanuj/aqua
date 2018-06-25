//
//  WaterViewController.swift
//  Aqua
//
//  Created by Rasesh Ramanuj on 06/06/2018.
//  Copyright © 2018 Rasesh Ramanuj. All rights reserved.
//

import UIKit
import HealthKit

let healthKitStore:HKHealthStore = HKHealthStore()

class WaterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var myCollectionView: UICollectionView!
    //Check clean code for these (lbl necessary?)
    @IBOutlet weak var lblToDrink: UILabel!
    @IBOutlet weak var lblDrankToday: UILabel!
    
    
    
    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Glasses.glassArray.glasses.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let glass = Glasses.glassArray.glasses[indexPath.row] //display all the records including completed
        if (!glass.drank) {
            addGlass(glass: glass)
            //Compound Assignment
         
        } else {
            removeGlass(glass: glass)
            //reset?
        }
      
        lblDrankToday.text = String(getDrankToday())
        lblToDrink.text = String(GlobalVar.dailyDrink - getDrankToday())
        myCollectionView.reloadData()
    }
    
    func removeGlass(glass: Glass) {
        //display all the records including completed
        glass.drank = false
        healthKitStore.delete(glass.healthkitObject) { (bool, error) in
            print("Deleted \(bool), error\(error ?? nil)")
        }
    }
    
    //date drank
    
    func createGlassInstance(ml: Double, glass: Glass) {
        let today = NSDate()
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater) {
            let litre = ml / 1000
            
            let quantity = HKQuantity(unit: HKUnit.liter(), doubleValue: litre)
            
            let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
            glass.ml = ml
            glass.healthkitObject = sample
            glass.drank = true//only edit tasks that have not yet been completed.
            lblDrankToday.text = String(getDrankToday())
            lblToDrink.text = String(GlobalVar.dailyDrink - getDrankToday())
            healthKitStore.save(sample, withCompletion: {(success, error) in
                print("Saved \(success), error\(error ?? nil)")
            })
        }
       
//        writeToKit(ml: ml)
        myCollectionView.reloadData()
        
    }

    func getDrankToday() -> Double {
        var drankToday = 0.0
        for glass in Glasses.glassArray.glasses {
            if (glass.drank) {
                drankToday+=glass.ml
        
            }
        }
        return drankToday
    }
    
    func addGlass(glass: Glass) {
      
        let alert = UIAlertController(title: "Select ML?", message: "Select ML", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "250 ml", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.createGlassInstance(ml: 250, glass:glass)
        }))
        alert.addAction(UIAlertAction(title: "300 ml", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            self.createGlassInstance(ml: 300, glass:glass)
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        let glass = Glasses.glassArray.glasses[indexPath.row] //display all the records including completed
        
        if glass.drank {
            cell.myImageView.image = UIImage(named: "glass.png")
        }
        else {
            cell.myImageView.image = UIImage(named: "1.png")
        }
        return cell
    }
    
    let needToDrink = 1800
    //TODO: create seperate instances of the 'water' class (default 300ml).
    //(value is unfilled ;). For each glass that's unfilled, every 2 hours send a reminder.
    //need a date algorithm.
    
    
    //only get alerted when you have water to drink. You can add as many glasses as you like.
   
    //what we need in order for the claculations.
    
    
    /*
     ON LOAD:
     
     Every time we drink a glass we just need to send a 'last drank' variable up
     //The individual states of the glass is irrelevant (though we can certainly store the individual instances)
     //within CoreData should we need to.
     
     With the 'lastDrank' date we check if it was today, if it was we keep the glass states (drank/not drank) the same
     else we reset all the instances.
     
     
     */
    

    func authorizeHealthKitInApp() {
        let healthKitTypesToRead: Set<HKObjectType> = [
            HKObjectType.characteristicType(forIdentifier:HKCharacteristicTypeIdentifier.dateOfBirth)!,
            //the difference between quantity/characterisistic, quan changes with time,
            //characteristic doesnt..
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        ]
        let healthKitTypesToWrite : Set<HKSampleType> = [   HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater)!]
        if !HKHealthStore.isHealthDataAvailable() {
            print("error occured")
            return
            
        }
        healthKitStore.requestAuthorization(toShare: healthKitTypesToWrite, read: healthKitTypesToRead) { (success, error) in
            print("read write Aurhotization successfull")
        }
    }
    
    func writeToKit(ml: Double) {
        
        //let weight = Double(self.txtWeight.text!)
        let today = NSDate()
        if let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.dietaryWater) {
        let litre = ml / 1000
        
        let quantity = HKQuantity(unit: HKUnit.liter(), doubleValue: litre)
    
        let sample = HKQuantitySample(type: type, quantity: quantity, start: today as Date, end: today as Date)
            
            healthKitStore.save(sample, withCompletion: {(success, error) in
                print("Saved \(success), error\(error ?? nil)")
            })
        }
    }


    override func viewDidLoad()
    {
        super.viewDidLoad()
        let itemSize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        myCollectionView.collectionViewLayout = layout
        authorizeHealthKitInApp()
        //for loop to create 8 instances of the cup.
        
        // Do any additional setup after loading the view.
        for _ in 1...9 {
            let newGlass = Glass()
            Glasses.glassArray.glasses.append(newGlass)
        }
        lblToDrink.text = String(GlobalVar.dailyDrink)
        
        // 1 times 5 is 5
        // 2 times 5 is 10
        // 3 times 5 is 15
        // 4 times 5 is 20
        // 5 times 5 is 25

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
