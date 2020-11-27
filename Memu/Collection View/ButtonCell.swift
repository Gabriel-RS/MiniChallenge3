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
    @IBOutlet weak var btnHearing: UIButton!
    
    let isPlaying = LaunchpadViewController.isPlaying
    
    func lockImg() {
        if PuzzleViewController.locked == false {
            btnLock.setImage(UIImage(named: "unlocked"), for: .normal)
            if PuzzleViewController.timesLocked > 0 {
                btnLock.isEnabled = false
            }
        } else {
            btnLock.setImage(UIImage(named: "locked"), for: .normal)
        }
    }
    
    func disableBtnHearing() {
        if PuzzleViewController.ouvidas == 0 {
            btnHearing.isEnabled = false
        }
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        print("Delete Button")
        delegate?.delete()
    }
    
    @IBAction func btnLock(_ sender: Any) {
        if PuzzleViewController.locked == false && PuzzleViewController.timesLocked == 0 {
            PuzzleViewController.locked = true
            PuzzleViewController.timesLocked += 1
            
            btnLock.setImage(UIImage(named: "locked"), for: .normal)
            
            delegate?.playNote("feedback_bloqueada")
        }
        
        else if PuzzleViewController.locked {
            PuzzleViewController.locked = false
            lockImg()
            
            
            
            
        } else {
            print("não é possível bloquear mais de uma vez")
            // TODO: emitir som de tecla bloqueada
            
            lockImg()
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
            btnPlay.setImage(UIImage(named: "stop"), for: .normal)
        } else {
            btnPlay.setImage(UIImage(named: "play"), for: .normal)
        }
    }
    
    //Puzzle
    @IBAction func btnHearing(_ sender: Any) {
        print("Hearing Button")
        delegate?.play()
        disableBtnHearing()
    }
    
}

protocol ButtonCellDelegate: class {
    func delete()
    func play()
    //    func setFeedback(completionName: String)
    //    func playFeedback(feedbackType: String)
    func playNote(_ song: String)
}
