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
    
    // para ser chamado quando alterar as notas musicais
    func setNotes(notes: [Note]) {
        self.launchpad = notes
    }

    func getNotes() -> [Note] {
        return self.launchpad
    }
}
