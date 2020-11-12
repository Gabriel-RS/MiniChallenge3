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
    
    init(size: Int, instrument: String, isLaunchpad: Bool) {
        self.size = size
        self.instrument = instrument
        self.launchpad = [Note]()

        let possibleNotes = ["do", "re", "mi", "fa", "sol", "la", "si"]
        
        let possibleColors = ["Blue","Green","Red","Pink","Purple", "Orange","Yellow"]

        for i in 0..<size {
            let note = Note(name: possibleNotes[i], soundFile: "\(instrument)_nota_\(possibleNotes[i])", color: possibleColors[i])
            launchpad.append(note)
        }

    }
    
    // pega as cores para ser apresentado na collection view do launchpad
    func getKeyImagesLaunchpad() -> [UIImage] {
        var images = [UIImage]()
        for note in launchpad {
            print(note.image)
            images.append(note.image)
        }
        return images
    }
    
    // para ser chamado quando alterar as notas musicais
//    func setNotes(notes: [Note]) {
//        self.launchpad = notes
//    }
//
//    func getNotes() -> [Note] {
//        return self.launchpad
//    }
//
    
    // as notas vão ser as mesmas, mas a imagem será alterada
//    func getKeyImagesPuzzle() -> [UIImage] {
//        var puzzleImages = [UIImage]()
//        for _ in launchpad {
//            let grayKey = UIImage(named: "keyGrayOn")!
//            puzzleImages.append(grayKey)
//        }
//
//        return puzzleImages
//    }
//
}
