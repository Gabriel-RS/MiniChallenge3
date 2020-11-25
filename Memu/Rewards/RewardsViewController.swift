//
//  RewardsViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit
import CoreData

class RewardsViewController: UIViewController {
    
    var fetchedResultController: NSFetchedResultsController<PlayerProgress>!
    var frcNotes: NSFetchedResultsController<NoteProgress>!
    var playerProgress: PlayerProgress!
    var notes: [NoteProgress] = []
    
    let playerProgressManager = PlayerProgressManager.shared
    
    var noteDo: NoteProgress!
    var noteRe: NoteProgress!
    var noteMi: NoteProgress!
    var noteFa: NoteProgress!
    var noteSol: NoteProgress!
    var noteLa: NoteProgress!
    var noteSi: NoteProgress!
    
    // Player
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var progressViewPlayer: UIProgressView!
    @IBOutlet weak var btCheckProgress: UIButton!
    @IBOutlet weak var lbScore: UILabel!
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
        loadStyleProgressViews()
        loadProgressPlayer()
        loadStatusPlayer()
        loadNotesProgress()
        //noteDo.points = 15
        checkNote(noteDo, progressViewDo, medalNoteDo, noteDescriptionDo, buttonRewardDo)
        checkNote(noteRe, progressViewRe, medalNoteRe, noteDescriptionRe, buttonRewardRe)
        checkNote(noteMi, progressViewMi, medalNoteMi, noteDescriptionMi, buttonRewardMi)
        checkNote(noteFa, progressViewFa, medalNoteFa, noteDescriptionFa, buttonRewardFa)
        checkNote(noteSol, progressViewSol, medalNoteSol, noteDescriptionSol, buttonRewardSol)
        checkNote(noteLa, progressViewLa, medalNoteLa, noteDescriptionLa, buttonRewardLa)
        checkNote(noteSi, progressViewSi, medalNoteSi, noteDescriptionSi, buttonRewardSi)
        
//        print(playerProgress.level)
//        print(playerProgress.points)
        
        
        loadPage()
        
        
//        print(noteDo.name!)
//        print(noteRe.name!)
    }
    
    // carrega o progresso e descrição da Nota na tela
    func checkNote(_ note: NoteProgress, _ progressView: UIProgressView, _ medalNote: UIImageView, _ noteDescription: UILabel, _ buttonReward: UIButton) {
        let noteName = [
            "Dó": "C",
            "Ré": "D",
            "Mi": "E",
            "Fá": "F",
            "Sol": "G",
            "Lá": "A",
            "Si": "B",
        ]
        let noteSelect = noteName[note.name!]
        let imagesNote: [String] = ["iniciante", "bronze", "prata", "ouro"]
        
        print("nota level: \(note.level)")
        print("Nota selecionada: \(imagesNote[Int(note.level)])\(noteSelect!)")
        
        if note.level == 0 {
            note.pointsLevelUp = 3.0
            medalNote.image = UIImage(named: "\(imagesNote[Int(note.level)])\(noteSelect!)")
            noteDescription.text = "Jogue mais \(Int(note.pointsLevelUp-note.points)) vezes com a nota \(note.name!) e alcance o nível \(imagesNote[Int(note.level)+1])."
        } else if note.level == 1 {
            note.pointsLevelUp = 4
            medalNote.image = UIImage(named: "\(imagesNote[Int(note.level)])\(noteSelect!)")
            noteDescription.text = "Jogue mais \(Int(note.pointsLevelUp-note.points)) vezes com a nota \(note.name!) e alcance o nível \(imagesNote[Int(note.level)+1])."
        } else if note.level == 2 {
            note.pointsLevelUp = 5
            medalNote.image = UIImage(named: "\(imagesNote[Int(note.level)])\(noteSelect!)")
            noteDescription.text = "Jogue mais \(Int(note.pointsLevelUp-note.points)) vezes com a nota \(note.name!) e alcance o nível \(imagesNote[Int(note.level)+1])."
        } else {
            note.pointsLevelUp = 5
            note.points = 5
            medalNote.image = UIImage(named: "\(imagesNote[Int(note.level)])\(noteSelect!)")
            noteDescription.text = "Parabéns você é um Deus da nota \(note.name!)."
            progressView.progressTintColor = UIColor.yellow
        }
        
        if note.points >= note.pointsLevelUp && note.level < 3 {
            progressView.isHidden = true
            buttonReward.isHidden = false
            noteDescription.text = "Toque em obter recompensa para descobrir quantos pontos você conseguiu."
            if note.points == note.pointsLevelUp {
                note.points = 0
            } else if note.points > note.pointsLevelUp {
                note.points = note.points - note.pointsLevelUp
            }
        } else {
            buttonReward.isHidden = true
        }
        progressView.progress = note.points/note.pointsLevelUp
    }
    
    
    
    func loadNotesProgress() {
        let fetchRequest: NSFetchRequest<NoteProgress> = NoteProgress.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        frcNotes = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frcNotes.delegate = self
        do {
            try frcNotes.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        if noteDo == nil {
            noteDo = NoteProgress(context: context)
            noteDo.setValue("Dó", forKey: "name")
            noteDo.setValue(0, forKey: "level")
        }
        if noteRe == nil {
            noteRe = NoteProgress(context: context)
            noteRe.setValue("Ré", forKey: "name")
            noteRe.setValue(0, forKey: "level")
        }
        noteMi = NoteProgress(context: context)
        noteIsNull(note: noteMi, name: "Mi")
        
        noteFa = NoteProgress(context: context)
        noteIsNull(note: noteFa, name: "Fá")
        
        noteSol = NoteProgress(context: context)
        noteIsNull(note: noteSol, name: "Sol")
        
        noteLa = NoteProgress(context: context)
        noteIsNull(note: noteLa, name: "Lá")
        
        noteSi = NoteProgress(context: context)
        noteIsNull(note: noteSi, name: "Si")
    }
    
    func noteIsNull(note: NoteProgress, name: String) {
        if note.medal == nil {
            //note = NoteProgress(context: context)
            note.name = name
            //note.setValue(name, forKey: "name")
            note.setValue(0, forKey: "level")
        }
    }
    
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
            playerProgress.noteProgress?.name = "Dó"
            playerProgress.noteProgress?.name = "Ré"
//            playerProgress.noteProgress?.name = "Mi"
//            playerProgress.noteProgress?.name = "Fá"
//            playerProgress.noteProgress?.name = "Sol"
//            playerProgress.noteProgress?.name = "Lá"
//            playerProgress.noteProgress?.name = "Si"
        }
    }
    
    func loadStatusPlayer() {
        
        if playerProgress.points != 0 && playerProgress.level == 0 {
            playerProgress.level = 1
        }
        
        switch playerProgress.level {
            case 0:
                playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                playerProgress.medal = UIImage(named: "help") // imagem para testar
                playerProgress.descriptionTitle = "Comece a explorar as notas e os sons que elas tem."
                playerProgress.pointsLevelUp = 100.0
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                playerProgress.descriptionPoints = "Jogue a primeira vez para ganhar sua primeira medalha."
            case 1:
                playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                playerProgress.medal = UIImage(named: "medalhaExplorador")
                playerProgress.descriptionTitle = "Você busca conhecer os sons e explorar cada um deles."
                playerProgress.pointsLevelUp = 100.0
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                if playerProgress.points < playerProgress.pointsLevelUp {
                    playerProgress.descriptionPoints = "Acumule \(Int(playerProgress.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(playerProgress.level)])."
                } else {
                    playerProgress.descriptionPoints = "Clique no botão no final da barra de progresso para subir de nível."
                }
            case 2:
                playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                playerProgress.medal = UIImage(named: "medalhaAmador")
                playerProgress.descriptionTitle = "Você é amador."
                playerProgress.pointsLevelUp = 250.0
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                if playerProgress.points < playerProgress.pointsLevelUp {
                    playerProgress.descriptionPoints = "Acumule \(Int(playerProgress.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(playerProgress.level)])."
                } else {
                    playerProgress.descriptionPoints = "Clique no botão para subir de nível."
                }
            case 3:
                playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                playerProgress.medal = UIImage(named: "medalhaMestre")
                playerProgress.descriptionTitle = "Você é mestre."
                playerProgress.pointsLevelUp = 450.0
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                if playerProgress.points < playerProgress.pointsLevelUp {
                    playerProgress.descriptionPoints = "Acumule \(Int(playerProgress.pointsLevelUp)) pontos para conquistar o título de \(playerTitles[Int(playerProgress.level)])."
                } else {
                    playerProgress.descriptionPoints = "Clique no botão para subir de nível."
                }
            case 4:
                playerProgress.title = "\(playerTitles[Int(playerProgress.level)])"
                playerProgress.medal = UIImage(named: "medalhaDeus")
                playerProgress.descriptionTitle = "Você é Deus da música."
                playerProgress.pointsLevelUp = 450.0
                playerProgress.score = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
                playerProgress.descriptionPoints = "Parabéns você agora é um Deus da música."
                //lbScore.isHidden = true
            default:
                print("default")
        }
        // chega se os pontos do jogar é maior/igual ao quantidade necessária para subir de level e muda imagem do botão
        if playerProgress.points >= playerProgress.pointsLevelUp && playerProgress.level < 4 {
            btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
        }
        
        // salva progresso no CoreData
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadPage() {
        // Infos do Player
        lbTitle.text = playerProgress.title
        ivImage.image = playerProgress.medal as? UIImage
        lbDescription.text = playerProgress.descriptionTitle
        lbScore.text = playerProgress.score
        lbProgress.text = playerProgress.descriptionPoints
        progressViewPlayer.progress = playerProgress.points/playerProgress.pointsLevelUp
    }
    
    func loadStyleProgressViews() {
        progressViewPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewDo.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewRe.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewMi.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewFa.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewSol.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewLa.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewSi.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    }
    
    @IBAction func btCheckProgress(_ sender: Any) {
        if playerProgress.points >= playerProgress.pointsLevelUp {
            playerProgress.level+=1
            btCheckProgress.setImage(UIImage(named: "progressoPadrao"), for: .normal)
        }
        loadStatusPlayer()
        loadPage()
        if playerProgress.level > 0 && playerProgress.level < 4  {
            lbProgress.text = "Faltam \(Int(playerProgress.pointsLevelUp-playerProgress.points)) para você conquistar o título de \(playerTitles[Int(playerProgress.level)+1])."
        }
    }
    
    @IBAction func rewardDo(_ sender: Any) {
        print("Nota level: \(noteDo.level)")
        if noteDo.level == 0 {
            playerProgress.points+=10
        } else if noteDo.level == 1 {
            playerProgress.points+=15
        } else if noteDo.level == 2 {
            playerProgress.points+=20
        }
        buttonRewardDo.isHidden = true
        progressViewDo.isHidden = false
        if noteDo.level < 3 {
            noteDo.level+=1
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        loadProgressPlayer()
        loadStatusPlayer()
        loadPage()
        checkNote(noteDo, progressViewDo, medalNoteDo, noteDescriptionDo, buttonRewardDo)
    }
    
    @IBAction func rewardRe(_ sender: Any) {
    }
    
    @IBAction func rewardMi(_ sender: Any) {
    }
    
    @IBAction func rewardFa(_ sender: Any) {
    }
    
    @IBAction func rewardSol(_ sender: Any) {
    }
    
    @IBAction func rewardLa(_ sender: Any) {
    }
    
    @IBAction func rewardSi(_ sender: Any) {
    }
    
}

extension RewardsViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            case .update:
                print("Atualizado")
            default:
                print("Default")
        }
    }
}
