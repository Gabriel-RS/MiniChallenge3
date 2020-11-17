//
//  Sequence.swift
//  Memu
//
//  Created by Beatriz Sato on 13/11/20.
//

import Foundation
import UIKit

class Sequence {
    var size: Int
    var notes: [Note]
    
    init(size: Int) {
        self.size = size
        self.notes = [Note]()
        
        for _ in 0..<size {
            let note = Note(name: "off", soundFile: "", color: "", type: "sequence")
            notes.append(note)
        }
        
        // adiciona botão de deletar como ultimo elemento do array (fora do tamanho)
        let deleteNote = Note(name: "delete", soundFile: "", color: "", type: "delete")
        notes.append(deleteNote)
    }
    
    func reset() {
        self.notes = [Note]()
        for _ in 0..<size {
            let note = Note(name: "off", soundFile: "", color: "", type: "sequence")
            notes.append(note)
        }
        
        // adiciona botão de deletar como ultimo elemento do array (fora do tamanho)
        let deleteNote = Note(name: "delete", soundFile: "", color: "", type: "delete")
        notes.append(deleteNote)
    }
    
    func addNote(note: Note) {
        // cria uma nota do tipo sequencia
        let sequenceNote = Note(name: note.name, soundFile: note.soundFile, color: note.color, type: "sequence")
        
        // se a sequencia não estiver cheia
        if findFirstOffIndex() != -1 {
            // se for tecla do launchpad
            if(note.image == UIImage(named: "key\(note.color)On")) {
                sequenceNote.image = UIImage(named: "seq\(sequenceNote.color)On")!
                
            } else {
                // se for tecla do puzzle
                sequenceNote.image = UIImage(named: "seqGrayOn")!
            }
            
            notes[findFirstOffIndex()] = sequenceNote
        }
    }
    
    func eraseNote() -> Note{
        let blankNote = Note(name: "off", soundFile: "", color: "", type: "sequence")
        let lastNoteIndex = findLastNoteIndex() - 1
        if(lastNoteIndex != -1) {
            let erasedNote = notes[lastNoteIndex]
            notes[lastNoteIndex] = blankNote
            return erasedNote
        }
        
        return blankNote
    }
    
    // acha o primeiro elemento cujo nome é off para nota ser adicionada no lugar dele
    func findFirstOffIndex() -> Int{
        for i in 0..<size {
            if notes[i].name == "off" {
                return i
            }
        }
        return -1
    }
    
    func findLastNoteIndex() -> Int {
        var index = 0
        while (notes[index].name != "off" && index < size) {
            index+=1
        }
        
        return index
    }
    
    func isFull() -> Bool {
        for note in notes {
            if note.name == "off" && note.name != "delete" {
                return false
            }
        }
        return true
    }
}
