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
    @IBOutlet weak var btCheckProgress: UIButton!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var ivDo: UIImageView!
    @IBOutlet weak var pvDo: UIProgressView!
    @IBOutlet weak var btRewardDo: UIButton!
    @IBOutlet weak var lbDo: UILabel!
    
    let titles: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    let imgsNoteDo: [String] = ["inicianteC", "bronzeC", "prataC", "ouroC"]
    
    var level: Int = 1
    var levelDo: Int = 0
    var pointsToLevelUp: Float = 100.0
    var pointsTotal: Float = 10.0
    var noteDo: Float = 12.0
    var pvSizeDo: Float = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleProgressView(pvPlayer)
        styleProgressView(pvDo)
        
        pvDo.progress = noteDo/pvSizeDo
        btRewardDo.isHidden = true
        
        progressPlayer()
        //refreshPage(level)
        
    }
    
    func progressPlayer() {
        if pointsTotal > 0.0 && pointsToLevelUp == 100.0 {
            self.level = 1
        }
        
        if pointsTotal >= pointsToLevelUp {
            self.level+=1
        }
        
        if level == 2 {
            self.pointsToLevelUp = 250.0
        } else if level == 3 {
            self.pointsToLevelUp = 450.0
        }
        checkProgressPlayer()
        refreshPage(level)
    }
    
    func checkProgressPlayer() {
        lbScore.text = "\(Int(pointsTotal))/\(Int(pointsToLevelUp))"
        if pointsTotal >= pointsToLevelUp {
            btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
        }
        checkNoteDo()
        
//        if noteDo >= pvSizeDo {
////            self.levelDo+=1
//            pvDo.isHidden = true
//            btRewardDo.isHidden = false
//            lbDo.text = "Clique no botão para obter sua recompesa"
//            if noteDo == pvSizeDo {
//                self.noteDo = 0
//                self.pvSizeDo = 4
//            } else if noteDo > pvSizeDo {
//                noteDo = noteDo - pvSizeDo
//                self.pvSizeDo = 4
//            }
//            //pvDo.progress = noteDo/pvSizeDo
//        }
//        else {
//            if levelDo == 0 {
//                self.pvSizeDo = 3
//                ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//                lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível bronze."
//                pvDo.progress = noteDo/pvSizeDo
//            } else if levelDo == 1 {
//                self.pvSizeDo = 4
//                ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//                lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível prata."
//            } else if levelDo == 2 {
//                self.pvSizeDo = 5
//                ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//                lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível ouro."
//            } else {
//                ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//                lbDo.text = "Parabéns você é um Deus da nota Dó."
//            }
//
//        }
        pvPlayer.progress = pointsTotal/pointsToLevelUp
        lbScore.text = "\(Int(pointsTotal))/\(Int(pointsToLevelUp))"
    }
    
    func checkNoteDo() {
        if levelDo == 0 {
            self.pvSizeDo = 3
            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
            lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível bronze."
            pvDo.progress = noteDo/pvSizeDo
        } else if levelDo == 1 {
            self.pvSizeDo = 4
            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
            lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível prata."
        } else if levelDo == 2 {
            self.pvSizeDo = 5
            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
            lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível ouro."
        } else {
            self.pvSizeDo = 5
            self.noteDo = 5
            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
            lbDo.text = "Parabéns você é um Deus da nota Dó."
            pvDo.progressTintColor = UIColor.yellow
        }
        if noteDo >= pvSizeDo && levelDo < 3 {
            pvDo.isHidden = true
            btRewardDo.isHidden = false
            lbDo.text = "Toque em obter recompensa para descobrir quantos pontos você conseguiu."
            if noteDo == pvSizeDo {
                self.noteDo = 0
                //self.pvSizeDo = 4
            } else if noteDo > pvSizeDo {
                noteDo = noteDo - pvSizeDo
                //self.pvSizeDo = 4
            }
        }
        pvDo.progress = noteDo/pvSizeDo
    }
    
    func styleProgressView(_ pv: UIProgressView) {
        pv.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        //pv.setProgress(points, animated: true)
    }
    
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
        if level != 0 && level < 4  {
            lbProgress.text = "Faltam \(Int(pointsToLevelUp-pointsTotal)) para você conquistar o título de \(titles[level+1])."
        }
        if pointsTotal >= pointsToLevelUp {
            btCheckProgress.setImage(UIImage(named: "progressoPadrao"), for: .normal)
            progressPlayer()
            refreshPage(level)
        }
    }
    
    @IBAction func rewardDo(_ sender: Any) {
        if levelDo == 0 {
            pointsTotal+=10
        } else if levelDo == 1 {
            pointsTotal+=15
        } else if levelDo == 2 {
            pointsTotal+=20
        }
        
        btRewardDo.isHidden = true
        pvDo.isHidden = false
        if levelDo < 3 {
            self.levelDo+=1
        }
        //checkProgressPlayer()
        progressPlayer()
    }
    

}
