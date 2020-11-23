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
    
    let isPlaying = LaunchpadViewController.isPlaying

    func lockImg() {
        if PuzzleViewController.locked == false {
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
        if PuzzleViewController.locked {
            PuzzleViewController.locked = false
            btnLock.setImage(UIImage(named: "unlocked"), for: .normal)
        } else if PuzzleViewController.locked == false && PuzzleViewController.timesLocked == 0 {
            PuzzleViewController.locked = true
            PuzzleViewController.timesLocked += 1
            btnLock.setImage(UIImage(named: "locked"), for: .normal)
        } else {
            print("não é possível bloquear mais de uma vez")
            // TODO: emitir som de tecla bloqueada
        }
    }
    
    //Launchpad
    @IBAction func btnPlay(_ sender: Any) {
        print("Play Button")
        NotificationCenter.default.addObserver(self, selector: #selector(self.playImage(sender:)), name: NSNotification.Name.init("Playing"), object: nil)
        delegate?.play()
    }
    
    @objc func playImage(sender: Notification) {
        let isPlaying = LaunchpadViewController.isPlaying

        if isPlaying == true {
            btnPlay.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            btnPlay.setImage(UIImage(named: "play"), for: .normal)
        }
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
