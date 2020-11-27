//
//  Note.swift
//  Memu
//
//  Created by Beatriz Sato on 09/11/20.
//

import UIKit


class Note: Hashable {
    var id = UUID()
    private var name: String
    private var soundFile: String
    private var color: String
    private var image: UIImage
    
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
        if image == UIImage(named: "key\(color)Off") {
            image = UIImage(named: "key\(color)On")!
        } else {
            image = UIImage(named: "keyGrayOn")!
        }
    }
    
    func turnOff() {
        if image == UIImage(named: "key\(color)On") {
            image = UIImage(named: "key\(color)Off")!
        } else {
            image = UIImage(named: "keyGrayOff")!
        }
    }
    
    // MARK: Getters e Setters
    func getName() -> String {
        return self.name
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getSoundFile() -> String {
        return self.soundFile
    }
    
    func setSoundFile(soundFile: String) {
        self.soundFile = soundFile
    }
    
    func getColor() -> String {
        return self.color
    }
    
    func setColor(color: String) {
        self.soundFile = color
    }
    
    func getImage() -> UIImage {
        return image
    }
    
    func setImage(image: UIImage) {
        self.image = image
    }
    
    // MARK: Hashable Protocol Methods
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
