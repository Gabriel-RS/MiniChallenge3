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
    @IBOutlet weak var btProgressPlayer: UIButton!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var pvDo: UIProgressView!
    @IBOutlet weak var btRewardDo: UIButton!
    
    
    
    let titles: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    
    var level: Int = 2
    var pointsToLevelUp: Float = 0
    //var count: Float = 0.0
    var points: Float = 245.0
    var noteDo: Float = 3.0
    var levelNoteDo: Float = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pvPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        pvPlayer.setProgress(points, animated: true)
        
        pvDo.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        pvDo.setProgress(points, animated: true)
        pvDo.progress = noteDo/levelNoteDo
        btRewardDo.isHidden = true
        
        if level == 0 || level == 1 {
            self.pointsToLevelUp = 100.0
        } else if level == 2 {
            self.pointsToLevelUp = 250.0
        } else if level == 3 {
            self.pointsToLevelUp = 450.0
        }
        
//        if pointsToLevelUp == score {
//            btProgressPlayer.setImage(UIImage(named: "progressoOuro"), for: .normal)
//        }
        checkProgressPlayer()
        
        progressPlayer()
        refreshPage(level)
        
        
        //updateProgress()
    }
    
    func progressPlayer() {
        if points <= pointsToLevelUp {
            pvPlayer.progress = points/pointsToLevelUp
        }
        lbScore.text = "\(Int(points))/\(Int(pointsToLevelUp))"
    }
    
    func checkProgressPlayer() {
        if pointsToLevelUp == points {
            btProgressPlayer.setImage(UIImage(named: "progressoOuro"), for: .normal)
        }
        
        if noteDo >= levelNoteDo {
            pvDo.isHidden = true
            btRewardDo.isHidden = false
            lbProgress.text = "Clique no botão para obter sua recompesa"
        }
        
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
            lbProgress.text = "Faltam \(Int(pointsToLevelUp-points)) para você conquistar o título de \(titles[level+1])."
        }
    }
    
    @IBAction func rewardDo(_ sender: Any) {
        points+=10
        btRewardDo.isHidden = true
        pvDo.isHidden = false
        //refreshPage(level)
        progressPlayer()
    }
    

}
