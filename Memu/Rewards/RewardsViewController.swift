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
    //var notesProgress: [NoteProgress] = []
    
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
    let imgsNoteDo: [String] = ["inicianteC", "bronzeC", "prataC", "ouroC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProgressViews()
        buttonRewardDo.isHidden = true
        loadProgressPlayer()
        print(playerProgress.level)
        print(playerProgress.points)
        loadStatusPlayer()
        loadPage()
        loadNotesProgress()
        noteDo.points = 15
        checkNote(note: noteDo, progressView: progressViewDo)
        print(noteDo.name!)
        print(noteRe.name!)
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
        }
    }
    
    func loadStatusPlayer() {
        
        if playerProgress.points != 0 && playerProgress.level == 0 {
            playerProgress.level = 1
        }
        print("loadStatusPlayer: \(playerProgress.level)")
        
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
                    playerProgress.descriptionPoints = "Clique no botão para subir de nível."
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
        
        // Infos Nota Dó
        medalNoteDo.image = noteDo.medal as? UIImage
        progressViewDo.progress = noteDo.points/noteDo.pointsLevelUp
        noteDescriptionDo.text = noteDo.noteDescription

        // Infos Nota Ré
        medalNoteRe.image = noteRe.medal as? UIImage
        progressViewRe.progress = noteRe.points/noteRe.pointsLevelUp
        noteDescriptionRe.text = noteRe.noteDescription

        // Infos Nota Mi
        medalNoteMi.image = noteMi.medal as? UIImage
        progressViewMi.progress = noteMi.points/noteMi.pointsLevelUp
        noteDescriptionMi.text = noteMi.noteDescription

        // Infos Nota Fá
        medalNoteFa.image = noteFa.medal as? UIImage
        progressViewFa.progress = noteFa.points/noteFa.pointsLevelUp
        noteDescriptionFa.text = noteFa.noteDescription

        // Infos Nota Sol
        medalNoteSol.image = noteSol.medal as? UIImage
        progressViewSol.progress = noteSol.points/noteSol.pointsLevelUp
        noteDescriptionSol.text = noteSol.noteDescription

        // Infos Nota Lá
        medalNoteLa.image = noteLa.medal as? UIImage
        progressViewLa.progress = noteLa.points/noteLa.pointsLevelUp
        noteDescriptionLa.text = noteLa.noteDescription

        // Infos Nota Si
        medalNoteSi.image = noteSi.medal as? UIImage
        progressViewSi.progress = noteSi.points/noteSi.pointsLevelUp
        noteDescriptionSi.text = noteSi.noteDescription
    }
    
    func loadProgressViews() {
        progressViewPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewDo.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewRe.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewMi.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewFa.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewSol.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewLa.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewSi.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    }
    
    func loadNota() {
        
    }


    func checkNoteDo() {
        
        if noteDo.level == 0 {
            noteDo.pointsLevelUp = 3.0
            medalNoteDo.image = UIImage(named: "\(imgsNoteDo[Int(noteDo.level)])")
            noteDescriptionDo.text = "Jogue mais \(Int(noteDo.pointsLevelUp-noteDo.points)) vezes com a nota Dó e alcance o nível bronze."
            //progressViewDo.progress = noteDo.points/noteDo.pointsLevelUp
        } else if noteDo.level == 1 {
            noteDo.pointsLevelUp = 4
            medalNoteDo.image = UIImage(named: "\(imgsNoteDo[Int(noteDo.level)])")
            noteDescriptionDo.text = "Jogue mais \(Int(noteDo.pointsLevelUp-noteDo.points)) vezes com a nota Dó e alcance o nível prata."
        } else if noteDo.level == 2 {
            noteDo.pointsLevelUp = 5
            medalNoteDo.image = UIImage(named: "\(imgsNoteDo[Int(noteDo.level)])")
            noteDescriptionDo.text = "Jogue mais \(Int(noteDo.pointsLevelUp-noteDo.points)) vezes com a nota Dó e alcance o nível ouro."
        } else {
            noteDo.pointsLevelUp = 5
            noteDo.points = 5
            medalNoteDo.image = UIImage(named: "\(imgsNoteDo[Int(noteDo.level)])")
            noteDescriptionDo.text = "Parabéns você é um Deus da nota Dó."
            progressViewDo.progressTintColor = UIColor.yellow
        }
        if noteDo.points >= noteDo.pointsLevelUp && noteDo.level < 3 {
            progressViewDo.isHidden = true
            buttonRewardDo.isHidden = false
            noteDescriptionDo.text = "Toque em obter recompensa para descobrir quantos pontos você conseguiu."
            if noteDo.points == noteDo.pointsLevelUp {
                noteDo.points = 0
                //self.pvSizeDo = 4
            } else if noteDo.points > noteDo.pointsLevelUp {
                noteDo.points = noteDo.points - noteDo.pointsLevelUp
                //self.pvSizeDo = 4
            }
        }
        
        progressViewDo.progress = noteDo.points/noteDo.pointsLevelUp
    }
    
    func checkNote(note: NoteProgress, progressView: UIProgressView) {
        
        let imagesNote: [String] = ["iniciante", "bronze", "prata", "ouro"]
        
        if note.level == 0 {
            note.setValue(3.0, forKey: "pointsLevelUp")
        } else if note.level == 1 {
            note.setValue(4.0, forKey: "pointsLevelUp")
        } else if note.level == 2 {
            note.setValue(5.0, forKey: "pointsLevelUp")
        } else {
            note.setValue(5, forKey: "points")
            noteDescriptionDo.text = "Parabéns você é um Deus da nota Ré."
            progressView.progressTintColor = UIColor.yellow
        }
        medalNoteDo.image = UIImage(named: "\(imagesNote[Int(note.level)])\(note.name!)")
        if note.points >= note.pointsLevelUp && note.level < 3 {
            progressView.isHidden = true
            buttonRewardDo.isHidden = false
            noteDescriptionDo.text = "Toque em obter recompensa para descobrir quantos pontos você conseguiu."
            if note.points == note.pointsLevelUp {
                note.points = 0
            } else if note.points > note.pointsLevelUp {
                note.points = note.points - note.pointsLevelUp
            }
        }
        
        if note.level < 3 {
            noteDescriptionDo.text = "Jogue mais \(Int(note.pointsLevelUp-note.points)) vezes com a nota \(note.name!) e alcance o nível \(imagesNote[Int(note.level)+1])."
        }
        
        progressView.progress = note.points/note.pointsLevelUp
    }
    
    
    @IBAction func btCheckProgress(_ sender: Any) {
        if playerProgress.points >= playerProgress.pointsLevelUp {
            playerProgress.level+=1
            print("Botão: \(playerProgress.level)")
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
        checkNote(note: noteDo, progressView: progressViewDo)
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
