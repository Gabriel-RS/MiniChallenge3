//
//  NotesManager.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 25/11/20.
//

import CoreData

class NotesManager {
    static let shared = NotesManager()
    var notes: [NoteProgress] = []
    
    func loadNotes(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NoteProgress> = NoteProgress.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            notes = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        
    }
}
