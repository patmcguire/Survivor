//
//  ViewController.swift
//  Survivor
//
//  Created by Pat McGuire on 5/29/15.
//  Copyright (c) 2015 spark. All rights reserved.
//

import UIKit

class ChooseIsland: UIViewController {
    
    var islands = ["Solstice", "Chicago"]
    
    
    func numberOfComponentsInPickerView (pickerView: UIPickerView) -> Int{
        
        return 1
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
    return islands.count
    
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{
        return islands[row]
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

