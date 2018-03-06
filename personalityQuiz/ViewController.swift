//
//  ViewController.swift
//  personalityQuiz
//
//  Created by Samuel Ault on 2/28/18.
//  Copyright © 2018 John Hersey High School. All rights reserved.
//

import UIKit

class initialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func beginButtonPushed(_ sender: UIButton) {
        performSegue(withIdentifier: "resultsSegue", sender: nil)
    }
    
    
    }




