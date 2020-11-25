//
//  NoteProgress+CoreDataClass.swift
//  Memu
//
//  Created by Beatriz Sato on 20/11/20.
//
//

import Foundation
import CoreData

@objc(NoteProgress)
public class NoteProgress: NSManagedObject {
    
    // TODO: tirar todos os parametros nível da função (ele pega automaticamente como atributo)
    
    // TODO: pesquisar uso de tuplas, conjuntos, algum tipo de dado que englobe tudo isso
        
    // Método que passa o nível o novo num de jogadas necessárias
    func getGamesToPlay(level: Int) -> Int {
        switch level {
        case 0:
            return 3
        case 1:
            return 4
        case 2:
            return 5
        default:
            return -1
        }
    }
        
    // Método que passa o nível e retorna os pontos a serem ganhados
    func getRewardPoints(level: Int) -> Int {
        switch level {
        case 0:
            return 10
        case 1:
            return 15
        case 2:
            return 20
        default:
            return -1
        }
    }
    
    // Método que passa o nível e retorna a instrução
    func getInstruction(level: Int) -> String {
        switch level {
        case 0:
            return "Jogue mais \(gamesToPlay-gamesPlayed) vezes com a nota \(name!.capitalized) e alcance o nível bronze."
        case 1:
            return "Jogue mais \(gamesToPlay-gamesPlayed) vezes com a nota \(name!.capitalized) e alcance o nível prata."
        case 2:
            return "Jogue mais \(gamesToPlay-gamesPlayed) vezes com a nota \(name!.capitalized) e alcance o nível ouro."
        default:
            return "Parabéns você é um Deus da nota \(name!.capitalized)."
        }
    }
    
    // Método que passa o nível e retorna a instrução
    func getMedalName(level: Int, name: String) -> String {
        let notes = ["do": "C", "re": "D", "mi": "E", "fa": "F", "sol": "G", "la": "A", "si": "B"]
        
        switch level {
        case 0:
            let note = notes[name]
            return "iniciante\(note ?? "C")"
        case 1:
            let note = notes[name]
            return "bronze\(note ?? "C")"
        case 2:
            let note = notes[name]
            return "prata\(note ?? "C")"
        default:
            let note = notes[name]
            return "ouro\(note ?? "C")"
        }
    }
    
    
}
