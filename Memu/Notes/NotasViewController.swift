//
//  NotasViewController.swift
//  Memu
//
//  Created by Felipe Ferreira on 04/11/20.
//

import Foundation
import UIKit


class Notas: UIViewController {
    
    var aux:[String] = ["do", "re", "mi", "fa"]
    @IBOutlet weak var btnDo: UIButton!
    @IBOutlet weak var btnRe: UIButton!
    @IBOutlet weak var btnMi: UIButton!
    @IBOutlet weak var btnFa: UIButton!
    @IBOutlet weak var btnSol: UIButton!
    @IBOutlet weak var btnLa: UIButton!
    @IBOutlet weak var btnSi: UIButton!
    @IBOutlet weak var lblAviso: UILabel!
    
    
    
    @IBAction func btnDo(_ sender: UIButton) {
        selectedOrNot(btn: btnDo, nota: "do")
    }
    
    @IBAction func btnRe(_ sender: Any) {
        selectedOrNot(btn: btnRe, nota: "re")
    }
    
    
    @IBAction func btnMi(_ sender: Any) {
        selectedOrNot(btn: btnMi, nota: "mi")
    }
    
    @IBAction func btnFa(_ sender: Any) {
        selectedOrNot(btn: btnFa, nota: "fa")
    }
    
    
    @IBAction func btnSol(_ sender: Any) {
        selectedOrNot(btn: btnSol, nota: "sol")
    }
    
    @IBAction func btnLa(_ sender: Any) {
        selectedOrNot(btn: btnLa, nota: "la")
    }
    
    @IBAction func btnSi(_ sender: Any) {
        selectedOrNot(btn: btnSi, nota: "si")
    }
    
    @IBAction func btnInprime(_ sender: Any) {
        for i in 0...aux.count-1{
            print(aux[i])
        }
    }
    
    func selectedOrNot(btn: UIButton, nota: String){
        if(aux.count == 4) {
        lblAviso.isHidden = true
            if(btn.isSelected){
                btn.isSelected = false
                for i in 0...aux.count-1 {
                    if(aux[i] == nota) {
                        aux.remove(at: i)
                    }
                }
            } else {
                lblAviso.isHidden = false
            }
        } else if (aux.count < 4){
            if(btn.isSelected == false) {
                btn.isSelected = true
                aux.append(nota)
            }
        } else {
            btn.isSelected = false
            lblAviso.isHidden = false
        }
    }

    
}




