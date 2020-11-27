//
//  LaunchpadCell.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 05/11/20.
//

import UIKit

class LaunchpadCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: LaunchpadCell.self)

    @IBOutlet weak var keyOn: UIImageView!
    
    var noteKey: Note?
    
    func setNoteKey(note: Note) {
        self.noteKey = note
        keyOn.image = note.getImage()
    }
    
}
