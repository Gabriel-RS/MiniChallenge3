//
//  SequenceCell.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class SequenceCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: SequenceCell.self)
    
    @IBOutlet weak var image: UIImageView!
    
    var noteKey: Note?
    
    func setNoteKey(note: Note) {
        self.noteKey = note
        image.image = note.getImage()
    }
}
