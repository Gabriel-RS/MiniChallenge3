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
    var noteDo: NoteProgress!
    var noteRe: NoteProgress!
    var noteMi: NoteProgress!
    var noteFa: NoteProgress!
    var noteSol: NoteProgress!
    var noteLa: NoteProgress!
    var noteSi: NoteProgress!
    
    func loadNotes(with context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<NoteProgress> = NoteProgress.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        loadNotes(context: context)
        do {
            notes = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadNotes(context: NSManagedObjectContext) {
        if notes.count == 0 {
            initNotes(context: context)
        }
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // inicializas as Notas
    func initNotes(context: NSManagedObjectContext) {
        if noteDo == nil {
            noteDo = NoteProgress(context: context)
            noteDo.setValue("Dó", forKey: "name")
            noteDo.setValue(0, forKey: "level")
            notes.append(noteDo)
        }
        if noteFa == nil {
            noteFa = NoteProgress(context: context)
            noteFa.setValue("Fá", forKey: "name")
            noteFa.setValue(0, forKey: "level")
            notes.append(noteFa)
        }
        if noteLa == nil {
            noteLa = NoteProgress(context: context)
            noteLa.setValue("Lá", forKey: "name")
            noteLa.setValue(0, forKey: "level")
            notes.append(noteLa)
        }
        if noteMi == nil {
            noteMi = NoteProgress(context: context)
            noteMi.setValue("Mi", forKey: "name")
            noteMi.setValue(0, forKey: "level")
            notes.append(noteMi)
        }
        if noteRe == nil {
            noteRe = NoteProgress(context: context)
            noteRe.setValue("Ré", forKey: "name")
            noteRe.setValue(0, forKey: "level")
            notes.append(noteRe)
        }
        if noteSi == nil {
            noteSi = NoteProgress(context: context)
            noteSi.setValue("Si", forKey: "name")
            noteSi.setValue(0, forKey: "level")
            notes.append(noteSi)
        }
        if noteSol == nil {
            noteSol = NoteProgress(context: context)
            noteSol.setValue("Sol", forKey: "name")
            noteSol.setValue(0, forKey: "level")
            notes.append(noteSol)
        }
    }
    
    private init() {
        
    }
}
