//
//  WaterViewController.swift
//  Aqua
//
//  Created by Rasesh Ramanuj on 06/06/2018.
//  Copyright © 2018 Rasesh Ramanuj. All rights reserved.
//

import UIKit

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
            glass.drank = true//only edit tasks that have not yet been completed.
        }
        GlobalVar.dailyDrink = GlobalVar.dailyDrink - glass.ml
        lblToDrink.text = String(GlobalVar.dailyDrink)

        myCollectionView.reloadData()
        
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
    
    //Didset, send the glass instance over to the global singleton. We can do some pulls here. The global singleton is
    //what we need in order for the claculations.
    
    
    /*
     ON LOAD:
     
     Every time we drink a glass we just need to send a 'last drank' variable up
     //The individual states of the glass is irrelevant (though we can certainly store the individual instances)
     //within CoreData should we need to.
     
     With the 'lastDrank' date we check if it was today, if it was we keep the glass states (drank/not drank) the same
     else we reset all the instances.
     
     
     */
    

    
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
