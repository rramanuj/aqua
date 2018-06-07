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
    
    
    let array:[String] = ["1","2","3","4","5","6","7","8",]
    
    //Number of views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! myCell
        cell.myImageView.image = UIImage(named: "glass.png")
        return cell
    }
    
    let needToDrink = 1800
    //TODO: create seperate instances of the 'water' class (default 300ml).
    //(value is unfilled ;). For each glass that's unfilled, every 2 hours send a reminder.
    //need a date algorithm.
    
    
    //only get alerted when you have water to drink. You can add as many glasses as you like.
    
    //Didset, send the glass instance over to the global singleton. We can do some pulls here. The global singleton is
    //what we need in order for the claculations.
    

    override func viewDidLoad() {
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
