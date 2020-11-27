//
//  TutorialViewController.swift
//  Memu
//
//  Created by Beatriz Sato on 03/11/20.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var bottomNavView: UIView!
    
    var launchpadVc = LaunchpadViewController()
    
    let tutorialHasLaunched: Bool = UserDefaults.standard.bool(forKey: "tutorialHasLaunched")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if tutorialHasLaunched == false {
            button.isHidden = false
            titleLabel.isHidden = false
            btnClose.isHidden = true
            navBar.isHidden = true
            bottomNavView.isHidden = true
        }
    }

    @IBAction func playTutorial(_ sender: Any) {
        print("hora de jogar")
        
        launchpadVc.playNote("feedback_interface")
        
        if tutorialHasLaunched == false {
            let storyboard = UIStoryboard(name: "Launchpad", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "LaunchpadViewController")
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
            self.present(secondVC, animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
