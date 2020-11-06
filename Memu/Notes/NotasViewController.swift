//
//  NotasViewController.swift
//  Memu
//
//  Created by Felipe Ferreira on 04/11/20.
//

import Foundation
import UIKit


class Notas: UIViewController {
    
    @IBOutlet weak var btnDo: UIButton!
    @IBOutlet weak var btnRe: UIButton!
    @IBOutlet weak var btnMi: UIButton!
    @IBOutlet weak var btnFa: UIButton!
    @IBOutlet weak var btnSol: UIButton!
    @IBOutlet weak var btnLa: UIButton!
    @IBOutlet weak var btnSi: UIButton!
    
    
    
    @IBAction func btnDo(_ sender: UIButton) {
        selectedOrNot(btn: btnDo)
    }
    
    @IBAction func btnRe(_ sender: Any) {
        selectedOrNot(btn: btnRe)
    }
    
    
    @IBAction func btnMi(_ sender: Any) {
        selectedOrNot(btn: btnMi)
    }
    
    @IBAction func btnFa(_ sender: Any) {
        selectedOrNot(btn: btnFa)
    }
    
    
    @IBAction func btnSol(_ sender: Any) {
        selectedOrNot(btn: btnSol)
    }
    
    @IBAction func btnLa(_ sender: Any) {
        selectedOrNot(btn: btnLa)
    }
    
    @IBAction func btnSi(_ sender: Any) {
        selectedOrNot(btn: btnSi)
    }
    
    func selectedOrNot(btn: UIButton){
        if(btn.isSelected){
            btn.isSelected = false
        } else {
            btn.isSelected = true
        }
    }
    
}
