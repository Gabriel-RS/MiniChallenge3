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
    
    var launchpadVc = LaunchpadViewController()
    
    @IBAction func btnContinue(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnNewGame(_ sender: Any) {
        let segue = "newGame"
        let msg = "Deseja realmente iniciar um novo jogo?"
        alert(segue, msg)
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnHome(_ sender: Any) {
        let segue = "homeScreen"
        let msg = "Deseja realmente voltar ao menu inicial?"
        alert(segue, msg)
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnHelp(_ sender: Any) {
        launchpadVc.playNote("feedback_interface")
    }
    
    func alert(_ segue: String, _ msg: String) {
        let warning = "Todo progresso atual será perdido."
        let alert = UIAlertController(title: msg, message: warning, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        let confirm = UIAlertAction(title: "Confirmar", style: .destructive) { (UIAlertAction) in
//            if segue == "homeScreen" {
//                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
//            } else {
                self.performSegue(withIdentifier: segue, sender: self)
//            }
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true, completion: nil)
    }
    
}

