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

    @IBOutlet weak var btnLock: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    
    let locked = LaunchpadViewController.locked
    
    func lockImg() {
        if locked == false {
            btnLock.setImage(UIImage(named: "unlocked"), for: .normal)
        } else {
            btnLock.setImage(UIImage(named: "locked"), for: .normal)
        }
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        print("Delete Button")
        delegate?.delete()
    }
    
    @IBAction func btnLock(_ sender: Any) {
        if locked == false {
            LaunchpadViewController.locked = true
            btnLock.setImage(UIImage(named: "locked"), for: .normal)
        } else {
            LaunchpadViewController.locked = false
            btnLock.setImage(UIImage(named: "unlocked"), for: .normal)
        }
    }
    
    //Launchpad
    @IBAction func btnPlay(_ sender: Any) {
        print("Play Button")
        delegate?.play()
    }
    
    //Puzzle
    @IBAction func btnHearing(_ sender: Any) {
        print("Hearing Button")
        delegate?.play()
    }
    
}

protocol ButtonCellDelegate: class {
    func delete()
    func play()
}
