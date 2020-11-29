//
//  RewardsViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit
import CoreData

class RewardsViewController: UIViewController {
    
    var launchpadVc = LaunchpadViewController()
    var fetchedResultController: NSFetchedResultsController<PlayerProgress>!
    var playerProgress: PlayerProgress!
    var notesManager = NotesManager.shared
    var differenceScore = 0
    
    // Player
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var progressViewPlayer: UIProgressView!
    @IBOutlet weak var btCheckProgress: UIButton!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbDynamicScore: UILabel!
    @IBOutlet weak var lbProgress: UILabel!
    
    // Nota Dó
    @IBOutlet weak var medalNoteDo: UIImageView!
    @IBOutlet weak var progressViewDo: UIProgressView!
    @IBOutlet weak var buttonRewardDo: UIButton!
    @IBOutlet weak var noteDescriptionDo: UILabel!
    
    // Nota Ré
    @IBOutlet weak var medalNoteRe: UIImageView!
    @IBOutlet weak var progressViewRe: UIProgressView!
    @IBOutlet weak var buttonRewardRe: UIButton!
    @IBOutlet weak var noteDescriptionRe: UILabel!
    
    // Nota Mi
    @IBOutlet weak var medalNoteMi: UIImageView!
    @IBOutlet weak var progressViewMi: UIProgressView!
    @IBOutlet weak var buttonRewardMi: UIButton!
    @IBOutlet weak var noteDescriptionMi: UILabel!
    
    // Nota Fá
    @IBOutlet weak var medalNoteFa: UIImageView!
    @IBOutlet weak var progressViewFa: UIProgressView!
    @IBOutlet weak var buttonRewardFa: UIButton!
    @IBOutlet weak var noteDescriptionFa: UILabel!
    
    // Nota Sol
    @IBOutlet weak var medalNoteSol: UIImageView!
    @IBOutlet weak var progressViewSol: UIProgressView!
    @IBOutlet weak var buttonRewardSol: UIButton!
    @IBOutlet weak var noteDescriptionSol: UILabel!
    
    // Nota Lá
    @IBOutlet weak var medalNoteLa: UIImageView!
    @IBOutlet weak var progressViewLa: UIProgressView!
    @IBOutlet weak var buttonRewardLa: UIButton!
    @IBOutlet weak var noteDescriptionLa: UILabel!
    
    // Nota Si
    @IBOutlet weak var medalNoteSi: UIImageView!
    @IBOutlet weak var progressViewSi: UIProgressView!
    @IBOutlet weak var buttonRewardSi: UIButton!
    @IBOutlet weak var noteDescriptionSi: UILabel!
    
    let playerTitles: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProgressPlayer()
        loadStatusPlayer()
        loadNotes()
        checkNote(0, progressViewDo, medalNoteDo, noteDescriptionDo, buttonRewardDo)
        checkNote(1, progressViewFa, medalNoteFa, noteDescriptionFa, buttonRewardFa)
        checkNote(2, progressViewLa, medalNoteLa, noteDescriptionLa, buttonRewardLa)
        checkNote(3, progressViewMi, medalNoteMi, noteDescriptionMi, buttonRewardMi)
        checkNote(4, progressViewRe, medalNoteRe, noteDescriptionRe, buttonRewardRe)
        checkNote(5, progressViewSi, medalNoteSi, noteDescriptionSi, buttonRewardSi)
        checkNote(6, progressViewSol, medalNoteSol, noteDescriptionSol, buttonRewardSol)
       // loadPage()
        
        
    }
    
    // carrega as informações do Player
    func loadProgressPlayer() {
        let fetchRequest: NSFetchRequest<PlayerProgress> = PlayerProgress.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        playerProgress = fetchedResultController.fetchedObjects?.first
        if playerProgress == nil {
            playerProgress = PlayerProgress(context: context)
            playerProgress.level = 0
        }
    }
    
    // de acordo com o nível do Player exibi as informações na tela
    func loadStatusPlayer() {
        
        let actualScore = Int(playerProgress.points)
        updateScore(difference: 0, actualScore: actualScore)
        
        if playerProgress.points != 0 && playerProgress.level == 0 {
            playerProgress.level = 1
            let actualScore = Int(playerProgress.points)
            updateScore(difference: 0, actualScore: actualScore)
        }
        switch playerProgress.level {
            case 0:
                //playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                lbTitle.text = "\(playerTitles[Int(playerProgress.level)])"
                //playerProgress.medal = UIImage(named: "medalhaAmadorOff") // imagem para testar
                ivImage.image = UIImage(named: "medalhaAmadorOff")
                //playerProgress.descriptionTitle = "Comece a explorar as notas e os sons que elas tem."
                lbDescription.text = "Comece a explorar as notas e os sons que elas tem."
                playerProgress.pointsLevelUp = 100.0
                lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                playerProgress.descriptionPoints = "Jogue a primeira vez para ganhar sua primeira medalha de ouro."
                //differenceScore = Int(playerProgress.pointsLevelUp)
                let actualScore = Int(playerProgress.points)
                updateScore(difference: 0, actualScore: actualScore)
            case 1:
                //playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                lbTitle.text = "\(playerTitles[Int(playerProgress.level)])"
                //playerProgress.medal = UIImage(named: "medalhaExplorador")
                ivImage.image = UIImage(named: "medalhaExplorador")
//                playerProgress.descriptionTitle = "Você busca conhecer os sons e explorar cada um deles."
                lbDescription.text = "Você busca conhecer os sons e explorar cada um deles."
                playerProgress.pointsLevelUp = 100.0
                lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
                let actualScore = Int(playerProgress.points)
                updateScore(difference: 0, actualScore: actualScore)
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                if playerProgress.points < playerProgress.pointsLevelUp {
                    playerProgress.descriptionPoints = "Acumule \(Int(playerProgress.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(playerProgress.level)])."
                } else {
                    playerProgress.descriptionPoints = "Você conquistou a medalha ouro de \(playerTitles[Int(playerProgress.level)]). Clique no botão no final da barra de progresso para subir de nível."
                }
            case 2:
                //playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                lbTitle.text = "\(playerTitles[Int(playerProgress.level)])"
                //playerProgress.medal = UIImage(named: "medalhaAmador")
                ivImage.image = UIImage(named: "medalhaAmador")
//                playerProgress.descriptionTitle = "Você agora é um músico amador e já tem dominio algumas das notas musicais."
                lbDescription.text = "Todo profissional já foi um amador, continue treinando e aprendendo!"
                playerProgress.pointsLevelUp = 250.0
                lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
                let actualScore = Int(playerProgress.points)
                updateScore(difference: 0, actualScore: actualScore)
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                if playerProgress.points < playerProgress.pointsLevelUp {
                    playerProgress.descriptionPoints = "Acumule \(Int(playerProgress.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(playerProgress.level)])."
                } else {
                    playerProgress.descriptionPoints = "Você conquistou a medalha ouro de \(playerTitles[Int(playerProgress.level)]). Clique no botão no final da barra de progresso para subir de nível."
                }
            case 3:
                //playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                lbTitle.text = "\(playerTitles[Int(playerProgress.level)])"
                //playerProgress.medal = UIImage(named: "medalhaMestre")
                ivImage.image = UIImage(named: "medalhaMestre")
//                playerProgress.descriptionTitle = "Você é mestre."
                lbDescription.text = "Você é um mestre dos sons, conhece todos eles e sabe diferenciá-los."
                playerProgress.pointsLevelUp = 450.0
                lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
                let actualScore = Int(playerProgress.points)
                updateScore(difference: 0, actualScore: actualScore)
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                if playerProgress.points < playerProgress.pointsLevelUp {
                    playerProgress.descriptionPoints = "Acumule \(Int(playerProgress.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(playerProgress.level)])."
                } else {
                    playerProgress.descriptionPoints = "Você conquistou a medalha ouro de \(playerTitles[Int(playerProgress.level)]). Clique no botão no final da barra de progresso para subir de nível."
                }
            case 4:
                //playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                lbTitle.text = "\(playerTitles[Int(playerProgress.level)])"
                //playerProgress.medal = UIImage(named: "medalhaDeus")
                ivImage.image = UIImage(named: "medalhaDeus")
//                playerProgress.descriptionTitle = "Você é Deus da música."
                lbDescription.text = "Você atingiu o nível mais alto de todos: o Deus da música! Agora o céu é o limite."
                playerProgress.pointsLevelUp = 450.0
                lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
                let actualScore = Int(playerProgress.points)
                updateScore(difference: 0, actualScore: actualScore)
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                playerProgress.descriptionPoints = "Parabéns você agora é um Deus da música."
                //lbScore.isHidden = true
            default:
                print("default")
        }
        
        progressViewPlayer.progress = playerProgress.points/playerProgress.pointsLevelUp
        
        // checa se os pontos do jogar é maior/igual ao quantidade necessária para subir de level e muda imagem do botão
        if playerProgress.points >= playerProgress.pointsLevelUp && playerProgress.level < 4 {
            btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
        }
        
        // modifica tamanho da ProgressView
        progressViewPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        
        // salva progresso no CoreData
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // carrega as informações das Notas
    func loadNotes() {
        notesManager.loadNotes(with: context)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // método que verifica o progresso de cada Nota e exibe infos de acordo com o level que o Player está na Nota
    func checkNote(_ index: Int, _ progressView: UIProgressView, _ medalNote: UIImageView, _ noteDescription: UILabel, _ buttonReward: UIButton) {
        let noteName = [
            "Dó": "C",
            "Ré": "D",
            "Mi": "E",
            "Fá": "F",
            "Sol": "G",
            "Lá": "A",
            "Si": "B",
        ]
        let noteSelect = noteName[notesManager.notes[index].name!]
        let imagesNote: [String] = ["iniciante", "bronze", "prata", "ouro"]
        
        if notesManager.notes[index].level == 0 {
            notesManager.notes[index].pointsLevelUp = 3.0
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = "Jogue mais \(Int(notesManager.notes[index].pointsLevelUp-notesManager.notes[index].points)) vezes com a nota \(notesManager.notes[index].name!) e alcance o nível \(imagesNote[Int(notesManager.notes[index].level)+1])."
        } else if notesManager.notes[index].level == 1 {
            notesManager.notes[index].pointsLevelUp = 4
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = "Jogue mais \(Int(notesManager.notes[index].pointsLevelUp-notesManager.notes[index].points)) vezes com a nota \(notesManager.notes[index].name!) e alcance o nível \(imagesNote[Int(notesManager.notes[index].level)+1])."
        } else if notesManager.notes[index].level == 2 {
            notesManager.notes[index].pointsLevelUp = 5
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = "Jogue mais \(Int(notesManager.notes[index].pointsLevelUp-notesManager.notes[index].points)) vezes com a nota \(notesManager.notes[index].name!) e alcance o nível \(imagesNote[Int(notesManager.notes[index].level)+1])."
        } else {
            notesManager.notes[index].pointsLevelUp = 5
            notesManager.notes[index].points = 5
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = "Parabéns você é um Deus da nota \(notesManager.notes[index].name!)."
            progressView.progressTintColor = UIColor(named: "pvOuro")
        }
        
        // verifica se o Player tem recompensa para obter da Nota, se sim esconde a progress view e mostra o botão da recompensa
        if notesManager.notes[index].points >= notesManager.notes[index].pointsLevelUp && notesManager.notes[index].level < 3 {
            progressView.isHidden = true
            buttonReward.isHidden = false
            noteDescription.isHidden = true
            //noteDescription.text = "Toque em obter recompensa para descobrir quantos pontos você conseguiu."
        } else {
            buttonReward.isHidden = true
        }
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressView.progress = notesManager.notes[index].points/notesManager.notes[index].pointsLevelUp
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // carrega infos do Jogador na Tela
//    func loadPage() {
//        // Infos do Player
//        lbTitle.text = playerProgress.title
//        ivImage.image = playerProgress.medal as? UIImage
//        lbDescription.text = playerProgress.descriptionTitle
//        lbScore.text = playerProgress.score
//        lbProgress.text = playerProgress.descriptionPoints
//        progressViewPlayer.progress = playerProgress.points/playerProgress.pointsLevelUp
//    }
    
    // método que checa se o Player tem recompensa para receber da Nota
    func refreshRewardNote(_ index: Int, _ progressView: UIProgressView, _ medalNote: UIImageView, _ noteDescription: UILabel, _ buttonReward: UIButton) {
        
        let actualScore = Int(playerProgress.points)
        if notesManager.notes[index].level == 0 {
            playerProgress.points+=10
            updateScore(difference: 10, actualScore: actualScore)
        } else if notesManager.notes[index].level == 1 {
            playerProgress.points+=15
            updateScore(difference: 15, actualScore: actualScore)
        } else if notesManager.notes[index].level == 2 {
            playerProgress.points+=20
            updateScore(difference: 20, actualScore: actualScore)
        }
        buttonReward.isHidden = true
        progressView.isHidden = false
        noteDescription.isHidden = false
        if notesManager.notes[index].level < 3 {
            notesManager.notes[index].level+=1
        }
        if notesManager.notes[index].points == notesManager.notes[index].pointsLevelUp {
            notesManager.notes[index].points = 0
        } else if notesManager.notes[index].points > notesManager.notes[index].pointsLevelUp {
            notesManager.notes[index].points = notesManager.notes[index].points - notesManager.notes[index].pointsLevelUp
        }
        loadStatusPlayer()
        loadNotes()
       // loadPage()
        checkNote(index, progressView, medalNote, noteDescription, buttonReward)
    }
    
    @IBAction func btCheckProgress(_ sender: Any) {
        if playerProgress.points >= playerProgress.pointsLevelUp && playerProgress.level > 0 && playerProgress.level < 4  {
            playerProgress.level+=1
            btCheckProgress.setImage(UIImage(named: "progressoPadrao"), for: .normal)
            if playerProgress.level >= 4 {
                btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
            }
        }
        if playerProgress.pointsLevelUp-playerProgress.points < 0 {
            lbProgress.text = "Você conquistou a medalha ouro de \(playerTitles[Int(playerProgress.level)]). Clique no botão no final da barra de progresso para subir de nível."
        }
        loadStatusPlayer()
        if playerProgress.level < 4 && playerProgress.points < playerProgress.pointsLevelUp {
           // loadPage()
            lbProgress.text = "Faltam \(Int(playerProgress.pointsLevelUp-playerProgress.points)) para você conquistar o título de \(playerTitles[Int(playerProgress.level)+1])."
        } else {
            //loadPage()
        }
    }
    
    @IBAction func rewardDo(_ sender: Any) {
        refreshRewardNote(0, progressViewDo, medalNoteDo, noteDescriptionDo, buttonRewardDo)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    @IBAction func rewardRe(_ sender: Any) {
        refreshRewardNote(4, progressViewRe, medalNoteRe, noteDescriptionRe, buttonRewardRe)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    @IBAction func rewardMi(_ sender: Any) {
        refreshRewardNote(3, progressViewMi, medalNoteMi, noteDescriptionMi, buttonRewardMi)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    @IBAction func rewardFa(_ sender: Any) {
        refreshRewardNote(1, progressViewFa, medalNoteFa, noteDescriptionFa, buttonRewardFa)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    @IBAction func rewardSol(_ sender: Any) {
        refreshRewardNote(6, progressViewSol, medalNoteSol, noteDescriptionSol, buttonRewardSol)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    @IBAction func rewardLa(_ sender: Any) {
        refreshRewardNote(2, progressViewLa, medalNoteLa, noteDescriptionLa, buttonRewardLa)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    @IBAction func rewardSi(_ sender: Any) {
        refreshRewardNote(5, progressViewSi, medalNoteSi, noteDescriptionSi, buttonRewardSi)
        launchpadVc.playNote("feedback_recompensa")
    }
    
    func updateScore(difference: Int, actualScore: Int) {

        let actualScore = actualScore
        let addScore = difference
        
        let totalScore = actualScore + difference
        
        playerProgress.points = Float(totalScore)

        print(difference)
        print(actualScore)
        

        animateIncrement(difference: difference, actualScore: actualScore, addScore: addScore, totalScore: totalScore)



    }

    func animateIncrement(difference: Int, actualScore: Int, addScore: Int, totalScore: Int) {
        

        if actualScore > totalScore {return}
        lbDynamicScore.text = "\(actualScore + addScore)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateIncrement(difference: difference, actualScore: actualScore + 1, addScore: addScore, totalScore: totalScore)
        }
    }
    
}

extension RewardsViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
    }
}
