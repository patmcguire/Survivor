//
//  PlayerHome.swift
//  Survivor
//
//  Created by Pat McGuire on 5/30/15.
//  Copyright (c) 2015 spark. All rights reserved.
//

import Foundation
import Parse

class PlayerHome: UIViewController{
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var userName = ""
    var parseClass = ""
    var tribe = ""
    
    @IBOutlet var tribeLbl: UILabel!
    
    
    override func viewDidLoad() {
        if let savedName = defaults.stringForKey("PlayerName"){
            userName = savedName
        }
        
        if let classAvail = defaults.stringForKey("gameClass"){
            parseClass = classAvail
        }
        
        
        var query = PFQuery(className: parseClass)
        query.whereKey("playerName", equalTo: userName)
        if var player = query.getFirstObject(){
            tribe = player["tribe"] as! String
        }
        
        if tribe == "tribe1"{
           self.view.backgroundColor = UIColor.purpleColor()
        }
        
        if tribe == "tribe2"{
            self.view.backgroundColor = UIColor.blueColor()
        }
        
        tribeLbl.text = "You are on \(tribe)"
    }
    
}