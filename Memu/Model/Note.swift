//
//  Note.swift
//  Memu
//
//  Created by Beatriz Sato on 09/11/20.
//

import UIKit


class Note: Hashable {
    var id = UUID()
    var name: String
    var soundFile: String
    var color: String
    var image: UIImage
    
    init(name: String, soundFile: String, color: String, type: String) {
        self.name = name
        self.soundFile = soundFile
        self.color = color
        image = UIImage()
        
        image = setInitialImage(type: type)
    }
    
    func setInitialImage(type: String) -> UIImage{
        switch(type){
        case "sequence":
            return UIImage(named: "seqOff")!
        case "sequenceOn":
            return UIImage(named: "seq\(self.color)On")!
        case "puzzle":
            return UIImage(named: "keyGrayOff")!
        case "delete":
            return UIImage(named: "delete")!
        case "invalid":
            return UIImage(named: "seqGrayOn")!
        default:
            return UIImage(named: "key\(self.color)Off")!
        }
    }
    
    func turnOn() {
        if image == UIImage(named: "keyGrayOff") {
            image = UIImage(named: "keyGrayOn")!
        } else {
            image = UIImage(named: "key\(color)On")!
        }
    }
    
    func turnOff() {
        if image == UIImage(named: "keyGrayOn") {
            image = UIImage(named: "keyGrayOff")!
        } else {
            image = UIImage(named: "key\(color)Off")!
        }
    }
    
    // MARK: Hashable Protocol Methods
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
