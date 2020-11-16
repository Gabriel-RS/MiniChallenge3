//
//  RewardsViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class RewardsViewController: UIViewController {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var pvPlayer: UIProgressView!
    
    @IBOutlet weak var lbScore: UILabel!
    
    @IBOutlet weak var pvProgress: UIProgressView!
    
    var nivel: Float = 3.0
    var count: Float = 0.0
    var score: Float = 0.0
    
    var bronze: Bool = true
    var prata: Bool = false
    var ouro: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        progressPlayer()
        //styleProgress()
    }
    
    func progressPlayer() {
        pvPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        pvPlayer.setProgress(score, animated: true)
        perform(#selector(updateProgressPlayer), with: nil, afterDelay: 1.0)
    }
    
    func styleProgress() {
        pvProgress.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        pvProgress.setProgress(count, animated: true)
        perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
    }
    
    @objc func updateProgressPlayer() {
        //count = count + 1.0
        pvPlayer.progress = score/150
        lbScore.text = "\(Int(score))/\(150)"
        
//        if score == 10 {
//            self.pvPlayer.progressImage = UIImage(named: "keyGreenOn")
//        }
        
        if score <= 150 {
            perform(#selector(updateProgressPlayer), with: nil, afterDelay: 1.0)
            self.score+=1.0
            
        }
    }
    
    @objc func updateProgress() {
        //count = count + 1.0
        pvProgress.progress = count/nivel
        
        if count <= nivel {
            perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
            self.count+=1.0
            
        } else if count > nivel && count <= nivel{
            self.nivel = 4
            self.count = 0
            pvProgress.progress = 0
            perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
        }
    }
    

}
