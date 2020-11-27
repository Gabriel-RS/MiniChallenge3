//
//  PlayerProgress+CoreDataClass.swift
//  Memu
//
//  Created by Beatriz Sato on 20/11/20.
//
//

import Foundation
import CoreData

@objc(PlayerProgress)
public class PlayerProgress: NSManagedObject {

    // TODO: tirar todos os parametros nível da função (ele pega automaticamente como atributo)
    
    // TODO: pesquisar uso de tuplas, conjuntos, algum tipo de dado que englobe tudo isso
    
    // Método que passa o nível e retorna o título e descrição
    func getTitle(level: Int) -> String {
        let titles: [String] = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
        
        return titles[level]
    }
    
    // Método que passa o nível e retorna a imagem
    func getImageName(level: Int) -> String {
        let imageNames = ["medalhaAmador", "medalhaAmador", "medalhaExplorador", "medalhaMestre", "medalhaDeus"]
        
        return imageNames[level]
    }
    
    // Método que passa o nível e retorna a instrução
    func getInstruction(level: Int) -> String {
        switch level {
        case 0:
            return "Jogue a primeira vez para ganhar sua primeira medalha."
        case 4:
            return "Parabéns você agora é um Deus da música."
        default:
            let titles = ["Desconhecido", "Explorador", "Músico amador", "Mestre dos sons", "Deus da música"]
            return "Acumule \(pointsToLevelUp) pontos para conquistar o título de \(titles[level+1])."
        }
    }
    
    // Método que passa o nível e retorna os pontos que faltam pro novo nível
    func getPointsToLevelUp(level: Int) -> Int{
        switch level {
        case 1:
            return 100
        case 2:
            return 250
        case 3:
            return 450
        default:
            return 0
        }
    }

}
