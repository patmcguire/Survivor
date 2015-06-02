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
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var parseClass = ""
    
    var chosenPlayer = ""
    
    var players: [String] = []
    
    
    //["Pat McGuire", "Jillian Offutt", "Dustin Vorac", "Andrea Miller", "Ryan Phillips", "Andy Sheehan", "Sampath Kunta", "Ellie Morrison", "Alec Nathan", "J"]
    
    let playerCellId = "PlayerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let classAvail = defaults.stringForKey("gameClass"){
            parseClass = classAvail
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        whoYouAreLbl.text = ""
        
        
        
        for i in 1...20{
            var query = PFQuery(className: parseClass)
            query.whereKey("playerId", equalTo: i)
            if var player = query.getFirstObject(){
                var playerName = player["playerName"] as! String
                players.append(playerName)
            }
        }
        
//        for i in 0...(players.count - 1){
//            println(players[i])
//        }
        
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
        chosenPlayer = players[row]
        whoYouAreLbl.text = players[row]
    }
    
    
    @IBAction func goBtn(sender: AnyObject) {
        passwordTxtField.endEditing(true)
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "GoToPlayerHome" {
            var requiredPass = ""
            var enteredPass: String = passwordTxtField.text
            
            var query = PFQuery(className: parseClass)
            query.whereKey("playerName", equalTo: chosenPlayer)
            if var player = query.getFirstObject(){
                requiredPass = player["password"] as! String
            }
            
            if requiredPass == enteredPass{
                defaults.setObject(chosenPlayer, forKey: "PlayerName")
                return true
            } else {
                passwordTxtField.textColor = UIColor.redColor()
                passwordTxtField.secureTextEntry = false
                passwordTxtField.text = "Incorrect Password"
                return false
            }
        }
        
        return false
    }
    
    @IBAction func startEditingTxtField(sender: AnyObject) {
        passwordTxtField.text = ""
        passwordTxtField.textColor = UIColor.blackColor()
        passwordTxtField.secureTextEntry = true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
        
}


