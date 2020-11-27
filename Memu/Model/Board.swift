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
    private var launchpad: [Note]
    // quantas notas vão ter no tabuleiro
    private var size: Int
    private var instrument: String
    
    init(size: Int, instrument: String, type: String) {
        self.size = size
        self.instrument = instrument
        self.launchpad = [Note]()

        // inicializa o tabuleiro com do re mi fa... 
        let possibleNotes = ["do", "re", "mi", "fa", "sol", "la", "si"]
        
        let possibleColors = ["Blue","Green","Red","Pink","Purple", "Orange","Yellow"]
        
        for i in 0..<size {
            let note = Note(name: possibleNotes[i], soundFile: "\(instrument)_nota_\(possibleNotes[i])", color: possibleColors[i], type: type)
            launchpad.append(note)
        }

    }
    
    // para ser chamado quando passar do launchpad para o puzzle
    func setPuzzleNotes(notes: [Note]) {
        let puzzleNotes = notes
        
        // atualiza as imagens sem alterar a cor
        for note in puzzleNotes {
            note.setImage(image: UIImage(named: "keyGrayOff")!)
        }
        
        self.launchpad = puzzleNotes
    }
    
    // troca as teclas de ordem na hora do puzzle
    func shuffleBoard() {
        launchpad.shuffle()
    }
    
    // MARK: Getters e Setters
    func getLaunchpad() -> [Note] {
        return launchpad
    }
    
    // para ser chamado quando alterar as notas musicais
    func setLaunchpad(notes: [Note]) {
        self.launchpad = notes
    }
    
    func getSize() -> Int {
        return size
    }
    
    func getInstrument() -> String {
        return instrument
    }
    
    func setInstrument(instrument: String) {
        self.instrument = instrument
    }
}
