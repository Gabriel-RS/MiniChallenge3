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
//        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnNewGame(_ sender: Any) {
        let segue = "newGame"
        let msg = NSLocalizedString("alertNewGame", comment: "Alert")
        alert(segue, msg)
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnHome(_ sender: Any) {
        let segue = "homeScreen"
        let msg = NSLocalizedString("alertMenu", comment: "Alert")
        alert(segue, msg)
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnHelp(_ sender: Any) {
        launchpadVc.playNote("feedback_interface")
    }
    
    func alert(_ segue: String, _ msg: String) {
        let warning = NSLocalizedString("alertWarning", comment: "Alert")
        let alert = UIAlertController(title: nil, message: warning, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: NSLocalizedString("cancelButton", comment: "Alert"), style: .default, handler: nil)
        let confirm = UIAlertAction(title: NSLocalizedString("confirmButton", comment: "Alert"), style: .destructive) { (UIAlertAction) in
            self.performSegue(withIdentifier: segue, sender: self)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}

