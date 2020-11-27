//
//  Sequence.swift
//  Memu
//
//  Created by Beatriz Sato on 13/11/20.
//

import Foundation
import UIKit

class Sequence {
    private var size: Int
    private var notes: [Note]
    
    init(size: Int) {
        self.size = size
        self.notes = [Note]()
        
        newSequence()
    }
    
    func newSequence() {
        self.notes = [Note]()
        for _ in 0..<size {
            let note = Note(name: "off", soundFile: "", color: "", type: "sequence")
            notes.append(note)
        }
        
        // adiciona botão de deletar como ultimo elemento do array (fora do tamanho)
        addDeleteButton()
    }
    
    func addNote(note: Note) {
        // cria uma nota do tipo sequencia
        let sequenceNote = Note(name: note.getName(), soundFile: note.getSoundFile(), color: note.getColor(), type: "sequence")
        
        // se a sequencia não estiver cheia
        if findFirstOffIndex() != -1 {
            // se for tecla do launchpad
            if(note.getImage() == UIImage(named: "key\(note.getColor())On")) {
                sequenceNote.setImage(image: UIImage(named: "seq\(sequenceNote.getColor())On")!)
                
            } else {
                // se for tecla do puzzle
                sequenceNote.setImage(image: UIImage(named: "seqGrayOn")!)
            }
            
            notes[findFirstOffIndex()] = sequenceNote
            
        }
    }
    
    func addDeleteButton() {
        let deleteButton = Note(name: "delete", soundFile: "", color: "", type: "delete")
        notes.append(deleteButton)
    }
    
    func eraseNote() -> Note{
        let blankNote = Note(name: "off", soundFile: "", color: "", type: "sequence")
        
        // acha a ultima nota existente na sequencia
        let lastNoteIndex = findLastNoteIndex() - 1
        
        // se sequencia não estiver vazia
        if (lastNoteIndex != -1) {
            let erasedNote = notes[lastNoteIndex]
            notes[lastNoteIndex] = blankNote
            return erasedNote
        }
        
        return blankNote
    }
    
    // acha o primeiro elemento cujo nome é off para nota ser adicionada no lugar dele
    func findFirstOffIndex() -> Int{
        for i in 0..<size {
            if notes[i].getName() == "off"{
                return i
            }
        }
        return -1
    }
    
    // pega a primeira nota da sequencia que pode ser excluída
    func findLastNoteIndex() -> Int {
        var index = 0
        while (notes[index].getName() != "off" && index < size) {
            index+=1
        }
        
        return index
    }
    
    func isFull() -> Bool {
        for note in notes {
            if note.getName() == "off" && note.getName() != "delete" {
                return false
            }
        }
        return true
    }
    
    func allNotesWrong(resultSequence: [Note]) -> Bool {
        for note in resultSequence {
            if note.getImage() != UIImage(named: "seqGrayOn") && note.getName() != "delete" {
                return false
            }
        }
        return true
    }
    
    // MARK: Getters e Setters
    func getSize() -> Int {
        return size
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func setNotes(notes: [Note]) {
        self.notes = notes
    }

}
