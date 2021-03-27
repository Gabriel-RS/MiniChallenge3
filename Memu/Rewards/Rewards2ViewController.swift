//
//  RewardsViewController.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 06/03/21.
//

import UIKit
import CoreData

class Rewards2ViewController: UIViewController {
    
    // MARK: Properties
    var playerManager = PlayerManager.shared
    var launchpadVc = LaunchpadViewController()
    let playerTitlesPT: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
    let playerTitlesEN: [String] = ["Unknown", "Explorer", "Amateur Musician", "Sound Master", "Music God"]
    var indexButtonTapped: Int?
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var pvPlayer: UIProgressView!
    @IBOutlet weak var btCheckProgress: UIButton!
    @IBOutlet weak var lbDynamicScore: UILabel!
    @IBOutlet weak var lbScore: UILabel!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var btGetRewards: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Carrega infos do Jogador e das Notas
        playerManager.loadPlayer(with: context)
        playerManager.loadNotes(with: context)
        if playerManager.player.level == 0 && playerManager.player.points > 0 {
            playerManager.player.level+=1
        }
        
        // Informações do Jogador na tela
        loadInfo()
        
        pvPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    }
    
    // MARK: Functions
    // método que verifica o progresso de cada Nota e exibe infos de acordo com o level que o Player está na Nota
    func checkNotesProgress(note: NoteProgress, context: NSManagedObjectContext) {
        let noteName = ["Dó": "C", "Ré": "D", "Mi": "E", "Fá": "F", "Sol": "G", "Lá": "A", "Si": "B"]
        let n = noteName[note.name!]
        let imagesNote: [String] = ["iniciante", "bronze", "prata", "ouro"]
        switch note.level {
            case 0:
                note.pointsLevelUp = 3
                note.image = UIImage(named: "\(imagesNote[Int(note.level)])\(n!)")
                note.noteDescription =  String.localizedStringWithFormat(NSLocalizedString("noteProgressBronze", comment: "Note"), Int(note.pointsLevelUp-note.points), (note.name!))
            case 1:
                note.pointsLevelUp = 4
                note.image = UIImage(named: "\(imagesNote[Int(note.level)])\(n!)")
                note.noteDescription = String.localizedStringWithFormat(NSLocalizedString("noteProgressSilver", comment: "Note"), Int(note.pointsLevelUp-note.points), (note.name!))
            case 2:
                note.pointsLevelUp = 5
                note.image = UIImage(named: "\(imagesNote[Int(note.level)])\(n!)")
                note.noteDescription = String.localizedStringWithFormat(NSLocalizedString("noteProgressGold", comment: "Note"), Int(note.pointsLevelUp-note.points), (note.name!))
            default:
                note.pointsLevelUp = 5
                note.points = 5
                note.image = UIImage(named: "\(imagesNote[Int(note.level)])\(n!)")
                note.noteDescription = String.localizedStringWithFormat(NSLocalizedString("noteGodProgress", comment: "Note"), (note.name!))
                //progressView.progressTintColor = UIColor(named: "pvOuro")
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImagePlayer() {
        switch playerManager.player.level {
            case 0:
                playerManager.player.image = UIImage(named: "medalhaAmadorOff")
            case 1:
                playerManager.player.image = UIImage(named: "medalhaExplorador")
            case 2:
                playerManager.player.image = UIImage(named: "medalhaAmador")
            case 3:
                playerManager.player.image = UIImage(named: "medalhaMestre")
            default:
                playerManager.player.image = UIImage(named: "medalhaDeus")
        }
    }
    
    func loadInfo() {
        playerManager.loadPlayer(with: context)
        loadImagePlayer()
        lbTitle.text = playerManager.player.title
        ivImage.image = playerManager.player.image as? UIImage
        lbDescription.text = playerManager.player.descriptionTitle
        pvPlayer.progress = playerManager.player.points/playerManager.player.pointsLevelUp
        lbProgress.text = playerManager.player.descriptionPoints
        lbDynamicScore.text = "\(Int(playerManager.player.points))"
        lbScore.text = " / \(Int(playerManager.player.pointsLevelUp))"
        if playerManager.player.points >= playerManager.player.pointsLevelUp && playerManager.player.level < 4 {
            btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
        }
        // salva progresso no CoreData
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateScore(difference: Int, actualScore: Int) {
        let addScore = difference
        let totalScore = actualScore + difference
        animateIncrement(difference: difference, actualScore: actualScore, addScore: addScore, totalScore: totalScore)
        loadInfo()
        loadImagePlayer()
    }
    
    func animateIncrement(difference: Int, actualScore: Int, addScore: Int, totalScore: Int) {
        if actualScore > totalScore {return}
        lbDynamicScore.text = "\(actualScore)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animateIncrement(difference: difference, actualScore: actualScore + 1, addScore: addScore, totalScore: totalScore)
        }
    }
    
    // MARK: IBActions
    @IBAction func checkProgress(_ sender: Any) {
        let locale = Locale.current.identifier
        print(locale.prefix(2))
                
        if playerManager.player.points >= playerManager.player.pointsLevelUp && playerManager.player.level > 0 && playerManager.player.level < 4 {
            playerManager.player.level+=1
            btCheckProgress.setImage(UIImage(named: "progressoPadrao"), for: .normal)
            if playerManager.player.level >= 4 {
                btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
            }
        }
        
        if locale.prefix(2) == "pt"{
            if playerManager.player.pointsLevelUp - playerManager.player.points < 0 {
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("levelUp", comment: "Level"), (playerTitlesPT[Int(playerManager.player.level)]))
            }
            if playerManager.player.level < 4 && playerManager.player.points < playerManager.player.pointsLevelUp {
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("pointsLevelUp", comment: "Level"), (Int(playerManager.player.pointsLevelUp-playerManager.player.points)), (playerTitlesPT[Int(playerManager.player.level)+1]))
            }
        } else {
            if playerManager.player.pointsLevelUp-playerManager.player.points < 0 {
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("levelUp", comment: "Level"), (playerTitlesEN[Int(playerManager.player.level)]))
            }
            if playerManager.player.level < 4 && playerManager.player.points < playerManager.player.pointsLevelUp {
                lbProgress.text = String.localizedStringWithFormat(NSLocalizedString("pointsLevelUp", comment: "Level"), (Int(playerManager.player.pointsLevelUp-playerManager.player.points)), (playerTitlesEN[Int(playerManager.player.level)+1]))
            }
        }
        loadInfo()
    }
    
    @IBAction func getReward(_ sender: UIButton) {
        let actualScore = Int(playerManager.player.points)
        
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let index = tableView.indexPathForRow(at: point) else { return }
        self.indexButtonTapped = index[1]
        
        if playerManager.notes[indexButtonTapped!].level == 0 {
            playerManager.player.points+=10
            updateScore(difference: 10, actualScore: actualScore)
        } else if playerManager.notes[indexButtonTapped!].level == 1 {
            playerManager.player.points+=15
            updateScore(difference: 15, actualScore: actualScore)
        } else if playerManager.notes[indexButtonTapped!].level == 2 {
            playerManager.player.points+=20
            updateScore(difference: 20, actualScore: actualScore)
        }
        if playerManager.notes[indexButtonTapped!].level < 3 {
            playerManager.notes[indexButtonTapped!].level+=1
        }
        if playerManager.notes[indexButtonTapped!].points == playerManager.notes[indexButtonTapped!].pointsLevelUp {
            playerManager.notes[indexButtonTapped!].points = 0
        } else if playerManager.notes[indexButtonTapped!].points > playerManager.notes[indexButtonTapped!].pointsLevelUp {
            playerManager.notes[indexButtonTapped!].points = playerManager.notes[indexButtonTapped!].points - playerManager.notes[indexButtonTapped!].pointsLevelUp
        }
        loadInfo()
        loadImagePlayer()
        tableView.reloadData()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: UITableViewDataSource, UITableViewDelegate
extension Rewards2ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerManager.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RewardsTableViewCell
        checkNotesProgress(note: playerManager.notes[indexPath.row], context: context)
        cell.prepare(index: indexPath.row)
        return cell
    }
    
}

// MARK: NSFetchedResultsControllerDelegate
extension Rewards2ViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .update:
                print("Atualizado")
            default:
                print("Default")
        }
    }
}
