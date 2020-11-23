//
//  RewardsViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class RewardsViewController: UIViewController {
    
    // TESTE MÉTODOS CLASSE CORE DATA
    var playerProgress = PlayerProgress()
    var noteProgress = NoteProgress()
    
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
    
    var player: Player!
    var noteDo: NoteGame!
    var noteRe: NoteGame!
    var noteMi: NoteGame!
    var noteFa: NoteGame!
    var noteSol: NoteGame!
    var noteLa: NoteGame!
    var noteSi: NoteGame!
    var playerManager = PlayerManager.shared
    
    let playerTitles: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    let imgsNoteDo: [String] = ["inicianteC", "bronzeC", "prataC", "ouroC"]
    
    //var level: Int = 1
    //var levelDo: Int = 0
    //var pointsToLevelUp: Float = 100.0
    //var pointsTotal: Float = 10.0
    //var noteDo: Float = 12.0
    //var pvSizeDo: Float = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStatusPlayer()
        loadPage()
        loadProgressViews()
        btRewardDo.isHidden = true

        
        progressPlayer()
        //refreshPage(level)
        
        // TESTE MÉTODOS CLASSE CORE DATA
        print(playerProgress.getImageName(level: 2))
        print(noteProgress.getRewardPoints(level: 2))
        print(noteProgress.getMedalName(level: 3, name: "re"))
        

//        
//        progressPlayer()

    }
    
    func loadStatusPlayer() {
        if player == nil {
            player = Player(context: context)
            player.level = 1
            player.points = 150
        }
        
        if player.points != 0 && player.pointsLevelUp == 100.0 {
            player.level = 1
        }
        print("loadStatusPlayer: \(player.level)")
        
        switch player.level {
            case 0:
                player.title = "\(playerTitles[Int(player.level)])"
                player.medal = UIImage(named: "help") // imagem para testar
                player.descriptionTitle = "Comece a explorar as notas e os sons que elas tem."
                player.pointsLevelUp = 100.0
                player.score = "\(Int(player.points))/\(Int(player.pointsLevelUp))"
                player.descriptionPoints = "Jogue a primeira vez para ganhar sua primeira medalha."
            case 1:
                player.title = "\(playerTitles[Int(player.level)])"
                player.medal = UIImage(named: "medalhaExplorador")
                player.descriptionTitle = "Você busca conhecer os sons e explorar cada um deles."
                player.pointsLevelUp = 100.0
                player.score = "\(Int(player.points))/\(Int(player.pointsLevelUp))"
                if player.points < player.pointsLevelUp {
                    player.descriptionPoints = "Acumule \(Int(player.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(player.level)])."
                } else {
                    player.descriptionPoints = "Clique no botão para subir de nível."
                }
            case 2:
                player.title = "\(playerTitles[Int(player.level)])"
                player.medal = UIImage(named: "medalhaAmador")
                player.descriptionTitle = "Você é amador."
                player.pointsLevelUp = 250.0
                player.score = "\(Int(player.points))/\(Int(player.pointsLevelUp))"
                if player.points < player.pointsLevelUp {
                    player.descriptionPoints = "Acumule \(Int(player.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(player.level)])."
                } else {
                    player.descriptionPoints = "Clique no botão para subir de nível."
                }
            case 3:
                player.title = "\(playerTitles[Int(player.level)])"
                player.medal = UIImage(named: "medalhaMestre")
                player.descriptionTitle = "Você é mestre."
                player.pointsLevelUp = 450.0
                player.score = "\(Int(player.points))/\(Int(player.pointsLevelUp))"
                if player.points < player.pointsLevelUp {
                    player.descriptionPoints = "Acumule \(Int(player.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(player.level)])."
                } else {
                    player.descriptionPoints = "Clique no botão para subir de nível."
                }
            case 4:
                player.title = "\(playerTitles[Int(player.level)])"
                player.medal = UIImage(named: "medalhaDeus")
                player.descriptionTitle = "Você é Deus da música."
                player.pointsLevelUp = 450.0
                player.score = "\(Int(player.points))/\(Int(player.pointsLevelUp))"
                player.descriptionPoints = "Parabéns você agora é um Deus da música."
                //lbScore.isHidden = true
            default:
                print("default")
        }
        
        // salva progresso no CoreData
//        do {
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    func loadPage() {
        lbTitle.text = player.title
        ivImage.image = player.medal as! UIImage
        lbDescription.text = player.descriptionTitle
        lbScore.text = player.score
        lbProgress.text = player.descriptionPoints
        pvPlayer.progress = player.points/player.pointsLevelUp
    }
    
    func loadProgressViews() {
        // Progress View do Jogador
        pvPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        
        // Progress View da nota Dó
        pvDo.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    }
    
    func loadNota(_ nota: NoteGame) {
        
    }
    
//    func progressPlayer() {
//        if pointsTotal > 0.0 && pointsToLevelUp == 100.0 {
//            self.level = 1
//        }
//
//        if pointsTotal >= pointsToLevelUp {
//            self.level+=1
//        }
//
//        if level == 2 {
//            self.pointsToLevelUp = 250.0
//        } else if level == 3 {
//            self.pointsToLevelUp = 450.0
//        }
//        checkProgressPlayer()
//        //refreshPage(level)
//    }
//
//    func checkProgressPlayer() {
//        lbScore.text = "\(Int(pointsTotal))/\(Int(pointsToLevelUp))"
//        if pointsTotal >= pointsToLevelUp {
//            btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
//        }
//        checkNoteDo()
//
//        pvPlayer.progress = pointsTotal/pointsToLevelUp
//        lbScore.text = "\(Int(pointsTotal))/\(Int(pointsToLevelUp))"
//    }
//
//    func checkNoteDo() {
//        if levelDo == 0 {
//            self.pvSizeDo = 3
//            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//            lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível bronze."
//            pvDo.progress = noteDo/pvSizeDo
//        } else if levelDo == 1 {
//            self.pvSizeDo = 4
//            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//            lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível prata."
//        } else if levelDo == 2 {
//            self.pvSizeDo = 5
//            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//            lbDo.text = "Jogue mais \(Int(pvSizeDo-noteDo)) vezes com a nota Dó e alcance o nível ouro."
//        } else {
//            self.pvSizeDo = 5
//            self.noteDo = 5
//            ivDo.image = UIImage(named: "\(imgsNoteDo[levelDo])")
//            lbDo.text = "Parabéns você é um Deus da nota Dó."
//            pvDo.progressTintColor = UIColor.yellow
//        }
//        if noteDo >= pvSizeDo && levelDo < 3 {
//            pvDo.isHidden = true
//            btRewardDo.isHidden = false
//            lbDo.text = "Toque em obter recompensa para descobrir quantos pontos você conseguiu."
//            if noteDo == pvSizeDo {
//                self.noteDo = 0
//                //self.pvSizeDo = 4
//            } else if noteDo > pvSizeDo {
//                noteDo = noteDo - pvSizeDo
//                //self.pvSizeDo = 4
//            }
//        }
//        pvDo.progress = noteDo/pvSizeDo
//    }
//
//    func styleProgressView(_ pv: UIProgressView) {
//        pv.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
//        //pv.setProgress(points, animated: true)
//    }
    
//    func refreshPage(_ level: Int) {
//        switch level {
//        case 0:
//            lbTitle.text = "\(playerTitles[level])"
//            lbDescription.text = "Comece a explorar as notas e os sons que elas tem."
//            lbProgress.text = "Jogue a primeira vez para ganhar sua primeira medalha."
//        case 1:
//            lbTitle.text = "\(playerTitles[level])"
//            ivImage.image = UIImage(named: "medalhaExplorador")
//            lbDescription.text = "Você busca conhecer os sons e explorar cada um deles."
//            lbProgress.text = "Acumule \(Int(pointsToLevelUp)) pontos para conquistar o título de \(playerTitles[level+1])."
//        case 2:
//            lbTitle.text = "\(playerTitles[level])"
//            ivImage.image = UIImage(named: "medalhaAmador")
//            lbDescription.text = "Amador."
//            lbProgress.text = "Acumule \(Int(pointsToLevelUp)) pontos para conquistar o título de \(playerTitles[level+1])."
//        case 3:
//            lbTitle.text = "\(playerTitles[level])"
//            ivImage.image = UIImage(named: "medalhaMestre")
//            lbDescription.text = "Mestre."
//            lbProgress.text = "Acumule \(Int(pointsToLevelUp)) pontos para conquistar o título de \(playerTitles[level+1])."
//        case 4:
//            lbTitle.text = "\(playerTitles[level])"
//            ivImage.image = UIImage(named: "medalhaDeus")
//            lbDescription.text = "Deus."
//            lbProgress.text = "Parabéns você agora é um Deus da música."
//            lbScore.isHidden = true
//        default:
//            print("default")
//        }
//    }
    
    @IBAction func btCheckProgress(_ sender: Any) {
        if player.level != 0 && player.level < 4  {
            lbProgress.text = "Faltam \(Int(player.points-player.pointsLevelUp)) para você conquistar o título de \(playerTitles[Int(player.level)+1])."
        }
        if player.points >= player.pointsLevelUp {
            player.level+=1
            print("Botão: \(player.level)")
            btCheckProgress.setImage(UIImage(named: "progressoPadrao"), for: .normal)
            
        }
        loadStatusPlayer()
        loadPage()
    }
    
    @IBAction func rewardDo(_ sender: Any) {
        
        
        
//        if levelDo == 0 {
//            pointsTotal+=10
//        } else if levelDo == 1 {
//            pointsTotal+=15
//        } else if levelDo == 2 {
//            pointsTotal+=20
//        }
//
//        btRewardDo.isHidden = true
//        pvDo.isHidden = false
//        if levelDo < 3 {
//            self.levelDo+=1
//        }
//        checkProgressPlayer()
//        progressPlayer()
    }
    

}
