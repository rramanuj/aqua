//
//  ViewController.swift
//  Aqua
//
//  Created by Rasesh Ramanuj on 06/06/2018.
//  Copyright © 2018 Rasesh Ramanuj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    
    @IBAction func btnCalculate(_ sender: Any) {
        let age = Double(txtAge.text!)
        let weight = Double(txtWeight.text!)

        let ounces = calculateWater(age: age!, weight: weight!)
        let ml = ounces * 28.41
        print(ml)
    }
    
    func calculateWater(age: Double, weight: Double) -> Double {
        //water = weight / 2.2
        // if < 30 * 40, if >30 <=55 * 35
        //if older than 55, multiply by 30
        
        //divide that by 38.3
        //answer is ounce
        
        let water = (weight / 2.2)
        var ounces: Double;
        
        if (age < 30) {
            ounces = water * 40
        }
        else if (age >= 30 && age <= 55) {
            ounces = water * 35
        }
        else {
            ounces = water * 30
        }
        
        ounces = ounces / 28.3
        return ounces
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

