//
//  ViewControlle+CoreData.swift
//  Memu
//
//  Created by Douglas Cardoso Ferreira on 20/11/20.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
