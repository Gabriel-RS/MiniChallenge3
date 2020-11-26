//
//  HomeScreenViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var launchpadVc = LaunchpadViewController()
    
    @IBAction func btnPlay(_ sender: Any) {
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnHelp(_ sender: Any) {
        launchpadVc.playNote("feedback_interface")
    }
    
    @IBAction func btnRewards(_ sender: Any) {
        launchpadVc.playNote("feedback_interface")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
