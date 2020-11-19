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
    @IBOutlet weak var btProgressPlayer: UIButton!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var pvProgress: UIProgressView!
    
    let titles: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    
    var level: Int = 2
    var pointsToLevelUp: Float = 0
    //var count: Float = 0.0
    var score: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressPlayer.setProgress(score, animated: true)
        
        pvProgress.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        pvProgress.setProgress(score, animated: true)
        pvProgress.progress = 1/3
        
        if level == 0 || level == 1 {
            self.pointsToLevelUp = 100.0
        } else if level == 2 {
            self.pointsToLevelUp = 150.0
        } else if level == 3 {
            self.pointsToLevelUp = 200.0
        }
        
        if pointsToLevelUp == score {
            btProgressPlayer.setImage(UIImage(named: "progressoOuro"), for: .normal)
        }
        
        
        test()
        refreshPage(level)
        
        
        //updateProgress()
    }
    
    func test() {
        if score <= pointsToLevelUp {
            progressPlayer.progress = score/pointsToLevelUp
        }
        lbScore.text = "\(Int(score))/\(Int(pointsToLevelUp))"
    }
    
//    func updateProgress() {
//        progressPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
//        progressPlayer.setProgress(score, animated: true)
//
//        //perform(#selector(updateProgressPlayer), with: nil, afterDelay: 1.0)
//    }
//
//    @objc func updateProgressPlayer() {
//
//        if level == 0 || level == 1 {
//            self.pointsToLevelUp = 10.0
//        } else if level == 2 {
//            self.pointsToLevelUp = 25.0
//        } else if level == 3 {
//            self.pointsToLevelUp = 40.0
//        }
//
//        progressPlayer.progress = score/pointsToLevelUp
//        lbScore.text = "\(Int(score))/\(Int(pointsToLevelUp))"
//
//        if score <= pointsToLevelUp {
//            levelUp(score, pointsToLevelUp)
//            perform(#selector(updateProgressPlayer), with: nil, afterDelay: 2.0)
//
//            //perform(#selector(updateProgressPlayer))
//
//        } else {
//            //perform(#selector(updateProgressPlayer), with: nil, afterDelay: 1.0)
//        }
//        refreshPage(level)
//
//    }
//
//    func levelUp(_ score: Float, _ pointsToLevelUp: Float) {
//
//
//
//        if level == 0 && score != 0 {
//            level+=1
//        }
//        if score == pointsToLevelUp {
//            self.level+=1
//            self.score = 0
//        }
//        self.score+=1
//    }
    
    func refreshPage(_ level: Int) {
        switch level {
        case 0:
            lbTitle.text = "\(titles[level])"
            lbDescription.text = "Comece a explorar as notas e os sons que elas tem."
            lbProgress.text = "Jogue a primeira vez para ganhar sua primeira medalha."
        case 1:
            lbTitle.text = "\(titles[level])"
            ivImage.image = UIImage(named: "medalhaExplorador")
            lbDescription.text = "Você busca conhecer os sons e explorar cada um deles."
            lbProgress.text = "Acumule \(Int(pointsToLevelUp)) pontos para conquistar o título de \(titles[level+1])."
        case 2:
            lbTitle.text = "\(titles[level])"
            ivImage.image = UIImage(named: "medalhaAmador")
            lbDescription.text = "Amador."
            lbProgress.text = "Acumule \(Int(pointsToLevelUp)) pontos para conquistar o título de \(titles[level+1])."
        case 3:
            lbTitle.text = "\(titles[level])"
            ivImage.image = UIImage(named: "medalhaMestre")
            lbDescription.text = "Mestre."
            lbProgress.text = "Acumule \(Int(pointsToLevelUp)) pontos para conquistar o título de \(titles[level+1])."
        case 4:
            lbTitle.text = "\(titles[level])"
            ivImage.image = UIImage(named: "medalhaDeus")
            lbDescription.text = "Deus."
            lbProgress.text = "Parabéns você agora é um Deus da música."
            lbScore.isHidden = true
        default:
            print("default")
        }
    }
    
    @IBAction func btCheckProgress(_ sender: Any) {
        if level != 0 && level != 4  {
            lbProgress.text = "Faltam \(Int(pointsToLevelUp-score)) para você conquistar o título de \(titles[level+1])."
        }
    }

}
