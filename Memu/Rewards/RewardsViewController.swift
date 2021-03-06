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
    
    let playerTitlesPT: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    
    let playerTitlesEN: [String] = ["Unknown", "Explorer", "Amateur Musician", "Sound Master", "Music God"]
    
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
        
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
        if playerProgress.points != 0 && playerProgress.level == 0 {
            playerProgress.level = 1
        }
        
        switch playerProgress.level {
        case 0:
            lbTitle.text = NSLocalizedString("unknownTitle", comment: "Title")
            ivImage.image = UIImage(named: "medalhaAmadorOff")
            lbDescription.text = NSLocalizedString("unknownDescription", comment: "Description")
            playerProgress.pointsLevelUp = 100.0
            lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
            lbProgress.text = NSLocalizedString("unknownLbProgress", comment: "Description")
            let actualScore = Int(playerProgress.points)
            updateScore(difference: 0, actualScore: actualScore)
        case 1:
            lbTitle.text = NSLocalizedString("explorerTitle", comment: "Title")
            ivImage.image = UIImage(named: "medalhaExplorador")
            lbDescription.text = NSLocalizedString("explorerDescription", comment: "Description")
            playerProgress.pointsLevelUp = 100.0
            lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
            if playerProgress.points < playerProgress.pointsLevelUp {
                lbProgress.text = NSLocalizedString("pointsExplorer", comment: "Points for medal")
            } else {
                lbProgress.text = NSLocalizedString("winMedalExplorer", comment: "Title Medal")
            }
            let actualScore = Int(playerProgress.points)
            updateScore(difference: 0, actualScore: actualScore)
        case 2:
            lbTitle.text = NSLocalizedString("amateurTitle", comment: "Title")
            ivImage.image = UIImage(named: "medalhaAmador")
            lbDescription.text = NSLocalizedString("amateurDescription", comment: "Description")
            playerProgress.pointsLevelUp = 250.0
            lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
            if playerProgress.points < playerProgress.pointsLevelUp {
                lbProgress.text = NSLocalizedString("pointsAmateur", comment: "Points for medal")
            } else {
                lbProgress.text = NSLocalizedString("winMedalAmateur", comment: "Title Medal")
            }
            let actualScore = Int(playerProgress.points)
            updateScore(difference: 0, actualScore: actualScore)
        case 3:
            lbTitle.text = NSLocalizedString("masterTitle", comment: "Title")
            ivImage.image = UIImage(named: "medalhaMestre")
            lbDescription.text = NSLocalizedString("masterDescription", comment: "Description")
            playerProgress.pointsLevelUp = 450.0
            lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
            if playerProgress.points < playerProgress.pointsLevelUp {
                lbProgress.text = NSLocalizedString("pointsMaster", comment: "Points for medal")
            } else {
                lbProgress.text = NSLocalizedString("winMedalMaster", comment: "Title Medal")
            }
            let actualScore = Int(playerProgress.points)
            updateScore(difference: 0, actualScore: actualScore)
        case 4:
            lbTitle.text = NSLocalizedString("godTitle", comment: "Title")
            ivImage.image = UIImage(named: "medalhaDeus")
            lbDescription.text = NSLocalizedString("godDescription", comment: "Description")
            playerProgress.pointsLevelUp = 450.0
            lbScore.text = " / \(Int(playerProgress.pointsLevelUp))"
            lbProgress.text = NSLocalizedString("godLbProgress", comment: "Description")
            btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
            let actualScore = Int(playerProgress.points)
            updateScore(difference: 0, actualScore: actualScore)
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
        //notesManager.loadNotes(with: context)
        print("Count notes: \(notesManager.notes.count)")
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
            noteDescription.text =  String.localizedStringWithFormat(NSLocalizedString("noteProgressBronze", comment: "Note"), Int(notesManager.notes[index].pointsLevelUp-notesManager.notes[index].points), (notesManager.notes[index].name!))
        } else if notesManager.notes[index].level == 1 {
            notesManager.notes[index].pointsLevelUp = 4
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = String.localizedStringWithFormat(NSLocalizedString("noteProgressSilver", comment: "Note"), Int(notesManager.notes[index].pointsLevelUp-notesManager.notes[index].points), (notesManager.notes[index].name!))
        } else if notesManager.notes[index].level == 2 {
            
            notesManager.notes[index].pointsLevelUp = 5
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = String.localizedStringWithFormat(NSLocalizedString("noteProgressGold", comment: "Note"), Int(notesManager.notes[index].pointsLevelUp-notesManager.notes[index].points), (notesManager.notes[index].name!))
            
        } else {
            notesManager.notes[index].pointsLevelUp = 5
            notesManager.notes[index].points = 5
            medalNote.image = UIImage(named: "\(imagesNote[Int(notesManager.notes[index].level)])\(noteSelect!)")
            noteDescription.text = String.localizedStringWithFormat(NSLocalizedString("noteGodProgress", comment: "Note"),(notesManager.notes[index].name!))
            progressView.progressTintColor = UIColor(named: "pvOuro")
        }
        
        // verifica se o Player tem recompensa para obter da Nota, se sim esconde a progress view e mostra o botão da recompensa
        if notesManager.notes[index].points >= notesManager.notes[index].pointsLevelUp && notesManager.notes[index].level < 3 {
            progressView.isHidden = true
            buttonReward.isHidden = false
            noteDescription.isHidden = true
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
        checkNote(index, progressView, medalNote, noteDescription, buttonReward)
    }
    
    @IBAction func btCheckProgress(_ sender: Any) {
        
        let locale = Locale.current.identifier
        
        print(locale)
        
        if playerProgress.points >= playerProgress.pointsLevelUp && playerProgress.level > 0 && playerProgress.level < 4  {
            playerProgress.level+=1
            btCheckProgress.setImage(UIImage(named: "progressoPadrao"), for: .normal)
            if playerProgress.level >= 4 {
                btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
            }
        }
        
        if locale.prefix(2) == "pt"{
            if playerProgress.pointsLevelUp-playerProgress.points < 0 {
                //            lbProgress.text = "Você conquistou a medalha ouro de \(playerTitles[Int(playerProgress.level)]). Clique no botão no final da barra de progresso para subir de nível."
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("levelUp", comment: "Level"), (playerTitlesPT[Int(playerProgress.level)]))
            }
            loadStatusPlayer()
            if playerProgress.level < 4 && playerProgress.points < playerProgress.pointsLevelUp {
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("pointsLevelUp", comment: "Level"), (Int(playerProgress.pointsLevelUp-playerProgress.points)), (playerTitlesPT[Int(playerProgress.level)+1]))
            }
        }
        else{
            if playerProgress.pointsLevelUp-playerProgress.points < 0 {
                //            lbProgress.text = "Você conquistou a medalha ouro de \(playerTitles[Int(playerProgress.level)]). Clique no botão no final da barra de progresso para subir de nível."
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("levelUp", comment: "Level"), (playerTitlesEN[Int(playerProgress.level)]))
            }
            loadStatusPlayer()
            if playerProgress.level < 4 && playerProgress.points < playerProgress.pointsLevelUp {
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("pointsLevelUp", comment: "Level"), (Int(playerProgress.pointsLevelUp-playerProgress.points)), (playerTitlesEN[Int(playerProgress.level)+1]))
            }
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
        //print(difference)
        //print(actualScore)
        
        animateIncrement(difference: difference, actualScore: actualScore, addScore: addScore, totalScore: totalScore)
    }
    
    func animateIncrement(difference: Int, actualScore: Int, addScore: Int, totalScore: Int) {
        if actualScore > totalScore {return}
        lbDynamicScore.text = "\(actualScore)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateIncrement(difference: difference, actualScore: actualScore + 1, addScore: addScore, totalScore: totalScore)
        }
    }
    
}

extension RewardsViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
    }
}
