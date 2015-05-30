//
//  WhoAreYou.swift
//  Survivor
//
//  Created by Pat McGuire on 5/30/15.
//  Copyright (c) 2015 spark. All rights reserved.
//

import Foundation
import UIKit
import Parse


class WhoAreYou: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var whoYouAreLbl: UILabel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var passwordTxtField: UITextField!
    
    var players: [String] = []
    
    //["Pat McGuire", "Jillian Offutt", "Dustin Vorac", "Andrea Miller", "Ryan Phillips", "Andy Sheehan", "Sampath Kunta", "Ellie Morrison", "Alec Nathan", "J"]
    
    let playerCellId = "PlayerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        whoYouAreLbl.text = ""
        
        
        
        for i in 1...20{
            var query = PFQuery(className: "sosltice1")
            query.whereKey("playerId", equalTo: i)
            if var player = query.getFirstObject(){
                var playerName = player["playerName"] as! String
                players.append(playerName)
            }
        }
        
        for i in 0...(players.count - 1){
            println(players[i])
        }
        
    }
        
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(playerCellId, forIndexPath: indexPath) as! UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = players[row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        println(players[row])
        whoYouAreLbl.text = players[row]
    }
    
    
    @IBAction func goBtn(sender: AnyObject) {
        
        
        
    }
    
        
}


