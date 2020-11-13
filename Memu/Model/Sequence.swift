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
    
    func addNote(note: Note) {
        // se a sequencia não estiver cheia
        if findFirstOffIndex() != -1 {
            let sequenceNote = note
            sequenceNote.image = UIImage(named: "seq\(sequenceNote.color)On")!
            notes[findFirstOffIndex()] = sequenceNote
        }
    }
    
    func eraseNote() -> Note{
        let blankNote = Note(name: "off", soundFile: "", color: "", type: "sequence")
        let lastNoteIndex = findLastNoteIndex() - 1
        let erasedNote = notes[lastNoteIndex]
        notes[lastNoteIndex] = blankNote
        
        return erasedNote
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
}
