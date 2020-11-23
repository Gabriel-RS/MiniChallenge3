//
//  PlayerManager.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 20/11/20.
//

import CoreData

class PlayerManager {
    static let shared = PlayerManager()
    var player = Player()
    
    func saveContext(with context: NSManagedObjectContext) {
        //try context.save()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        
        
//        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
//        do {
//            let rs = try context.fetch(fetchRequest)
//            rs[0].setValue(rs[0].level, forKey: "level")
//            try context.save()
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    private init() {
        
    }
}
