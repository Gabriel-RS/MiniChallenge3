//
//  RewardsTableViewCell.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 06/03/21.
//

import UIKit

class RewardsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var playerManager = PlayerManager.shared
    var index: Int?
    
    // MARK: IBOutlets
    @IBOutlet weak var ivNoteMedalImage: UIImageView!
    @IBOutlet weak var pvNote: UIProgressView!
    @IBOutlet weak var btReward: UIButton!
    @IBOutlet weak var lbNoteDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pvNote.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepare(index: Int) {
        self.index = index
        
        selectionStyle = .none
        ivNoteMedalImage.image = playerManager.notes[index].image as? UIImage
        lbNoteDescription.text = playerManager.notes[index].noteDescription
                
        // verifica se o Player tem recompensa para obter da Nota, se sim esconde a progress view e mostra o botão da recompensa
        if playerManager.notes[index].points >= playerManager.notes[index].pointsLevelUp && playerManager.notes[index].level < 3 {
            pvNote.isHidden = true
            btReward.isHidden = false
            lbNoteDescription.isHidden = true
        } else {
            pvNote.isHidden = false
            btReward.isHidden = true
            lbNoteDescription.isHidden = false
        }
        pvNote.progress = playerManager.notes[index].points/playerManager.notes[index].pointsLevelUp
        if playerManager.notes[index].level > 2 {
            pvNote.progressTintColor = UIColor(named: "pvOuro")
        }
    }
    
//    @IBAction func noteReward(_ sender: Any) {
////        let actualScore = Int(playerProgress.points)
//        if playerManager.notes[index].level == 0 {
//            playerManager.player.points+=10
//            //updateScore(difference: 10, actualScore: actualScore)
//        } else if playerManager.notes[index].level == 1 {
//            playerManager.player.points+=15
//            //updateScore(difference: 15, actualScore: actualScore)
//        } else if playerManager.notes[index].level == 2 {
//            playerManager.player.points+=20
//            //updateScore(difference: 20, actualScore: actualScore)
//        }
//        //btNoteReward.isHidden = true
//        pvNote.isHidden = false
//        lbNoteDescription.isHidden = false
//        if playerManager.notes[index].level < 3 {
//            playerManager.notes[index].level+=1
//        }
//        if playerManager.notes[index].points == playerManager.notes[index].pointsLevelUp {
//            playerManager.notes[index].points = 0
//        } else if playerManager.notes[index].points > playerManager.notes[index].pointsLevelUp {
//            playerManager.notes[index].points = playerManager.notes[index].points - playerManager.notes[index].pointsLevelUp
//        }
////        loadStatusPlayer()
////        loadNotes()
////        checkNote(index, progressView, medalNote, noteDescription, buttonReward)
//    }

}
