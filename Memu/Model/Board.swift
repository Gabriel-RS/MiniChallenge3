//
//  Board.swift
//  Memu
//
//  Created by Beatriz Sato on 09/11/20.
//

import Foundation
import UIKit

class Board {
    // sequencia de notas que entra no tabuleiro(launchpad) da tela launchpad e puzzle
    var launchpad: [Note]
    // quantas notas vão ter no tabuleiro
    var size: Int
    var instrument: String
    
    init(size: Int, instrument: String, type: String) {
        self.size = size
        self.instrument = instrument
        self.launchpad = [Note]()

        let possibleNotes = ["do", "re", "mi", "fa", "sol", "la", "si"]
        
        let possibleColors = ["Blue","Green","Red","Pink","Purple", "Orange","Yellow"]
        
        for i in 0..<size {
            let note = Note(name: possibleNotes[i], soundFile: "\(instrument)_nota_\(possibleNotes[i])", color: possibleColors[i], type: type)
            launchpad.append(note)
        }

    }
    
    // reseta como se fosse primeira vez jogando launchpad (do re mi fa)
    func reset() {
        self.launchpad = [Note]()
        let possibleNotes = ["do", "re", "mi", "fa", "sol", "la", "si"]
        
        let possibleColors = ["Blue","Green","Red","Pink","Purple", "Orange","Yellow"]
        
        for i in 0..<size {
            let note = Note(name: possibleNotes[i], soundFile: "\(instrument)_nota_\(possibleNotes[i])", color: possibleColors[i], type: "launchpad")
            launchpad.append(note)
        }
    }
    
    // para ser chamado quando alterar as notas musicais
    func setNotes(notes: [Note]) {
        self.launchpad = notes
    }
    
    // para ser chamado quando passar do launchpad para o puzzle
    func setPuzzleNotes(notes: [Note]) {
        let puzzleNotes = notes
        
        // atualiza as imagens sem alterar a cor
        for note in puzzleNotes {
            note.image = UIImage(named: "keyGrayOff")!
        }
        
        self.launchpad = puzzleNotes
    }

    // não tá sendo chamado
    func getNotes() -> [Note] {
        return self.launchpad
    }
    
    // não tá sendo chamado
    func turnOffWrong(notes: [Note]) {
        for i in 0..<notes.count {
            if notes[i].image == UIImage(named: "seqGrayOn") {
                launchpad[i].turnOff()
            }
        }
    }
    
    func shuffleBoard() {
        launchpad.shuffle()
    }
}
