//
//  NoteProgress+CoreDataProperties.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 23/11/20.
//
//

import Foundation
import CoreData


extension NoteProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteProgress> {
        return NSFetchRequest<NoteProgress>(entityName: "NoteProgress")
    }

    @NSManaged public var level: Int16
    @NSManaged public var medal: NSObject?
    @NSManaged public var noteDescription: String?
    @NSManaged public var points: Float
    @NSManaged public var pointsLevelUp: Float
    @NSManaged public var playerProgress: PlayerProgress?

}

extension NoteProgress : Identifiable {

}
