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
    @IBOutlet weak var progressPlayer: UIProgressView!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbProgress: UILabel!
    
    
    @IBOutlet weak var pvProgress: UIProgressView!
    
    let titles: [String] = ["Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    
    var nivel: Int = 0
    var count: Float = 0.0
    var score: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProgress()
    }
    
    func test(_ nivel: Int) {
        switch nivel {
        case 0:
            lbTitle.text = "\(titles[nivel])"
            ivImage.image = UIImage(named: "medalhaExplorador")
        case 1:
            lbTitle.text = "\(titles[nivel])"
            ivImage.image = UIImage(named: "medalhaAmador")
        case 2:
            lbTitle.text = "\(titles[nivel])"
            ivImage.image = UIImage(named: "medalhaMestre")
        case 3:
            lbTitle.text = "\(titles[nivel])"
            ivImage.image = UIImage(named: "medalhaDeus")
        default:
            print("default")
        }
    }
    
    
    
    func updateProgress() {
        progressPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressPlayer.setProgress(count, animated: true)

        perform(#selector(updateProgressPlayer), with: nil, afterDelay: 1.0)
    }
    
    @objc func updateProgressPlayer() {
        progressPlayer.progress = score/100
        lbScore.text = "\(Int(score))/\(100)"
        
        if score <= 150 {
            perform(#selector(updateProgressPlayer), with: nil, afterDelay: 1.0)
            self.score+=1.0
            if score == 10 {
                nivel = 1
            } else if score == 20 {
                nivel = 2
            } else if score == 30 {
                nivel = 3
            }
        }
        test(nivel)
    }
    
    
    @IBAction func btCheckProgress(_ sender: Any) {
        lbProgress.text = "Faltam \(Int(100-score)) para você conquistar o título de Músico amador."
    }
    
    
    
    
//    
//    @objc func updateProgress() {
//        //count = count + 1.0
//        pvProgress.progress = count/nivel
//        
//        if count <= nivel {
//            perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
//            self.count+=1.0
//            
//        } else if count > nivel && count <= nivel{
//            self.nivel = 4
//            self.count = 0
//            pvProgress.progress = 0
//            perform(#selector(updateProgress), with: nil, afterDelay: 1.0)
//        }
//    }
    

}
