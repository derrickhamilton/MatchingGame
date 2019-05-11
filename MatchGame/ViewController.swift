//
//  ViewController.swift
//  MatchGame
//
//  Created by iOSDev on 4/10/19.
//  Copyright © 2019 iOSDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movesMadeLbl: UILabel!
    @IBOutlet weak var movesLeftLbl: UILabel!
    var gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func flipCard(_ sender: UIButton) {
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

