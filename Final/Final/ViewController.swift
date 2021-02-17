//
//  ViewController.swift
//  Final
//
//  Created by ECENUR on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
            self.performSegue(withIdentifier: "goLogin", sender: nil)}
        
    }
    
}



