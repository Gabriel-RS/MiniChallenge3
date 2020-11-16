//
//  ButtonCell.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 05/11/20.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ButtonCell.self)
    static let reuseIdentifierDelete = "DeleteCell"
    
    weak var delegate: ButtonCellDelegate?
    
    @IBAction func btnDelete(_ sender: Any) {
        print("Delete Button")
        delegate?.delete()
    }
    
    @IBAction func btnPlay(_ sender: Any) {
        print("Play Button")
        delegate?.play()
    }
    
    @IBAction func btnLock(_ sender: Any) {
        print("Lock Button")
        let lock  = LaunchpadViewController.locked
        if lock == false {
            LaunchpadViewController.locked = true
        } else {
            LaunchpadViewController.locked = false
        }
    }
    
}

protocol ButtonCellDelegate: class {
    func delete()
    func play()
}
