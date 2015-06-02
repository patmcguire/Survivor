//
//  TribalCouncil.swift
//  Survivor
//
//  Created by Pat McGuire on 6/1/15.
//  Copyright (c) 2015 spark. All rights reserved.
//

import Foundation
import UIKit
import Parse

class TribalCouncil: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var selectedPlyrLbl: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var playersForVoting: [String] = []
    
    let textCellId = "PlayerCell"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var parseClass = ""
    
    var immunity = ""
    
    @IBOutlet var immunityLbl: UILabel!
    
    
    override func viewDidLoad() {
        
        if let classAvail = defaults.stringForKey("gameClass"){
            parseClass = classAvail
        }
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        selectedPlyrLbl.text = ""
        immunityLbl.text = ""
        
        var query = PFQuery(className: parseClass)
        query.whereKey("Tribal", equalTo: true)
        query.orderByAscending("playerName")
        if var votingOptions = query.findObjects(){
            
            for i in 0...(votingOptions.count-1){
                if votingOptions[i]["immunity"] as! Bool != true{
                    playersForVoting.append(votingOptions[i]["playerName"] as! String)
                } else{
                    immunity = votingOptions[i]["playerName"] as! String
                }
            }
            
            if immunity != "" {
                println("\(immunity) has an immunity idol.")
                immunityLbl.text = "\(immunity) has immunity."
            } else {
                println("No one has immunity on this tribe")
            }
            
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersForVoting.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellId, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = playersForVoting[row]
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        selectedPlyrLbl.text = playersForVoting[row]
    }
}
