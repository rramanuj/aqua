//
//  WaterViewController.swift
//  Aqua
//
//  Created by Rasesh Ramanuj on 06/06/2018.
//  Copyright © 2018 Rasesh Ramanuj. All rights reserved.
//

import UIKit

class WaterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //TODO: create seperate instances of the 'water' class (default 300ml).
    //(value is unfilled ;). For each glass that's unfilled, every 2 hours send a reminder.
    //need a date algorithm.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
