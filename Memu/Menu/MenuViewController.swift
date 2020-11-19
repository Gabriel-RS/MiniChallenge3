//
//  MenuViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func btnContinue(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnNewGame(_ sender: Any) {
        performSegue(withIdentifier: "newGame", sender: self)
    }
    
    @IBAction func btnHome(_ sender: Any) {
        performSegue(withIdentifier: "homeScreen", sender: self)
    }
    
    @IBAction func btnHelp(_ sender: Any) {
    }
    
}

