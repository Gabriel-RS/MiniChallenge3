//
//  PlayerProgress+CoreDataProperties.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 23/11/20.
//
//

import Foundation
import CoreData


extension PlayerProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerProgress> {
        return NSFetchRequest<PlayerProgress>(entityName: "PlayerProgress")
    }

    @NSManaged public var descriptionPoints: String?
    @NSManaged public var descriptionTitle: String?
    @NSManaged public var level: Int16
    @NSManaged public var medal: NSObject?
    @NSManaged public var points: Float
    @NSManaged public var pointsLevelUp: Float
    @NSManaged public var score: String?
    @NSManaged public var title: String?
    @NSManaged public var noteProgress: NoteProgress?

}

extension PlayerProgress : Identifiable {

}
