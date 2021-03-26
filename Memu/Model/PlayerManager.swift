//
//  PlayerManager.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 10/03/21.
//

import CoreData

class PlayerManager {
    
    static let shared = PlayerManager()
    var player: PlayerProgress!
    var notes: [NoteProgress] = []
    
    func loadPlayer(with context: NSManagedObjectContext) {
        
        let fetchRequest: NSFetchRequest<PlayerProgress> = PlayerProgress.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        do {
            player = try context.fetch(fetchRequest).first
        } catch {
            print(error.localizedDescription)
        }
        if player == nil {
            player = PlayerProgress(context: context)
            player.setValue(0, forKey: "level")
        }
        
        switch player.level {
            case 0:
                player.title = NSLocalizedString("unknownTitle", comment: "Title")
                player.descriptionTitle = NSLocalizedString("unknownDescription", comment: "Description")
                player.pointsLevelUp = 100.0
                player.descriptionPoints = NSLocalizedString("unknownLbProgress", comment: "Description")
//                let actualScore = Int(playerProgress.points)
//                updateScore(difference: 0, actualScore: actualScore)
            case 1:
                player.title = NSLocalizedString("explorerTitle", comment: "Title")
                player.descriptionTitle = NSLocalizedString("explorerDescription", comment: "Description")
                if player.points < player.pointsLevelUp {
                    player.descriptionPoints = NSLocalizedString("pointsExplorer", comment: "Points for medal")
                } else {
                    player.descriptionPoints = NSLocalizedString("winMedalExplorer", comment: "Title Medal")
                }
//                let actualScore = Int(playerProgress.points)
//                updateScore(difference: 0, actualScore: actualScore)
            case 2:
                player.title = NSLocalizedString("amateurTitle", comment: "Title")
                player.descriptionTitle = NSLocalizedString("amateurDescription", comment: "Description")
                player.pointsLevelUp = 250.0
                if player.points < player.pointsLevelUp {
                    player.descriptionPoints = NSLocalizedString("pointsAmateur", comment: "Points for medal")
                } else {
                    player.descriptionPoints = NSLocalizedString("winMedalAmateur", comment: "Title Medal")
                }
//                let actualScore = Int(playerProgress.points)
//                updateScore(difference: 0, actualScore: actualScore)
            case 3:
                player.title = NSLocalizedString("masterTitle", comment: "Title")
                player.descriptionTitle = NSLocalizedString("masterDescription", comment: "Description")
                player.pointsLevelUp = 450.0
                if player.points < player.pointsLevelUp {
                    player.descriptionPoints = NSLocalizedString("pointsMaster", comment: "Points for medal")
                } else {
                    player.descriptionPoints = NSLocalizedString("winMedalMaster", comment: "Title Medal")
                }
//                let actualScore = Int(playerProgress.points)
//                updateScore(difference: 0, actualScore: actualScore)
            default:
                player.title = NSLocalizedString("godTitle", comment: "Title")
                player.descriptionTitle = NSLocalizedString("godDescription", comment: "Description")
                player.descriptionPoints = NSLocalizedString("godLbProgress", comment: "Description")
//                btCheckProgress.setImage(UIImage(named: "progressoOuro"), for: .normal)
//                let actualScore = Int(playerProgress.points)
//                updateScore(difference: 0, actualScore: actualScore)
            //lbScore.isHidden = true
        }
    }
    
    func loadNotes(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NoteProgress> = NoteProgress.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "index", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            notes = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        if notes.isEmpty {
            creatingNotes(context: context)
        }
    }
    
    func creatingNotes(context: NSManagedObjectContext) {
        let noteNames = ["Dó", "Ré", "Mi", "Fá", "Sol", "Lá", "Si"]
        var note: NoteProgress!
        for (index, name) in noteNames.enumerated() {
            note = NoteProgress(context: context)
            note.setValue(index, forKey: "index")
            note.setValue(name, forKey: "name")
            note.setValue(0, forKey: "level")
            note.setValue(0, forKey: "points")
            note.setValue(0, forKey: "pointsLevelUp")
            notes.append(note)
        }
    }
    
    private init() {
    }
    
}
