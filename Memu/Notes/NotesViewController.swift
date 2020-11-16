//
//  NotasViewController.swift
//  Memu
//
//  Created by Felipe Ferreira on 04/11/20.
//

import Foundation
import UIKit
import AVFoundation

class Notas: UIViewController {
    
    var notes:[Note] = []
    var aux:Int = 0
    @IBOutlet weak var btnDo: UIButton!
    @IBOutlet weak var btnRe: UIButton!
    @IBOutlet weak var btnMi: UIButton!
    @IBOutlet weak var btnFa: UIButton!
    @IBOutlet weak var btnSol: UIButton!
    @IBOutlet weak var btnLa: UIButton!
    @IBOutlet weak var btnSi: UIButton!
    @IBOutlet weak var lblAviso: UILabel!
    var audioPlayer = AVAudioPlayer()
    var vetorNotas = [AVAudioPlayer]()
    var noteDo = Note(name: "do", soundFile: "marimba_nota_do.mp3", color: "Blue", type: "launchpad")
    var noteRe = Note(name: "re", soundFile: "marimba_nota_do.mp3", color: "Green", type: "launchpad" )
    var noteMi = Note(name: "mi", soundFile: "marimba_nota_do.mp3", color: "Red", type: "launchpad" )
    var noteFa = Note(name: "fa", soundFile: "marimba_nota_do.mp3", color: "Pink", type: "launchpad" )
    var noteSol = Note(name: "sol", soundFile: "marimba_nota_do.mp3", color: "Purple", type: "launchpad" )
    var noteLa = Note(name: "la", soundFile: "marimba_nota_do.mp3", color: "Orange", type: "launchpad" )
    var noteSi = Note(name: "si", soundFile: "marimba_nota_do.mp3", color: "Yellow", type: "launchpad" )
    
    override func viewDidLoad() {
        aux = notes.count
        loadBttns()
    }
    
    func loadBttns(){
        for note in notes {
            switch(note.name){
            case "do":
                btnDo.isSelected = true
                break;
            case "re":
                btnRe.isSelected = true
                break
            case "mi":
                btnMi.isSelected = true
                break
            case "fa":
                btnFa.isSelected = true
                break
            case "sol":
                btnSol.isSelected = true
                break
            case "la":
                btnLa.isSelected = true
                break;
            case "si":
                btnSi.isSelected = true
                break
            default:
                break
            }
        }
    }
    
    
    @IBAction func btnDo(_ sender: UIButton) {
        selectedOrNot(btn: btnDo, note: "do")
    }
    
    @IBAction func btnRe(_ sender: Any) {
        selectedOrNot(btn: btnRe, note: "re")
    }
    
    
    @IBAction func btnMi(_ sender: Any) {
        selectedOrNot(btn: btnMi, note: "mi")
    }
    
    @IBAction func btnFa(_ sender: Any) {
        selectedOrNot(btn: btnFa, note: "fa")
    }
    
    
    @IBAction func btnSol(_ sender: Any) {
        selectedOrNot(btn: btnSol, note: "sol")
    }
    
    @IBAction func btnLa(_ sender: Any) {
        selectedOrNot(btn: btnLa, note: "la")
    }
    
    @IBAction func btnSi(_ sender: Any) {
        selectedOrNot(btn: btnSi, note: "si")
    }
    
    
    //função para saber se o botõa está selecionado
    func selectedOrNot(btn: UIButton, note: String){
        //se o vetor de notas tiver tamanho quatro, ele apenas poderá remover notas
        if(aux == 4) {
            
                        lblAviso.isHidden = true
                        if(btn.isSelected){
                            btn.isSelected = false
                            aux -= 1
                        } else {
                            lblAviso.isHidden = false
                        }
        
        //se o número de notas for menor que 4, ele poderá incluir notas ou remover outras que ainda existam
        } else if (aux < 4){
            
                        //se o botão não está selecionado e a houver um click, o botão passa a estar selecionado e a nota toca
                        if(btn.isSelected == false) {
                            btn.isSelected = true
                            aux += 1
                            playSound(note: note)
                            //caso o botão já esteja selecionado e o usuário clicar, a nota é removida
                        } else {
                            btn.isSelected = false
                            aux -= 1
                            }
            
        } else {
                    
                        btn.isSelected = false
                        lblAviso.isHidden = false
            
        }
        
        
    }
    
    @IBAction func btnSegue(_ sender: Any) {
        defineNotas(btn: btnDo, note: noteDo)
        defineNotas(btn: btnRe, note: noteRe)
        defineNotas(btn: btnMi, note: noteMi)
        defineNotas(btn: btnFa, note: noteFa)
        defineNotas(btn: btnSol, note: noteSol)
        defineNotas(btn: btnLa, note: noteLa)
        defineNotas(btn: btnSi, note: noteSi)
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "unwind"){
            let vc = segue.destination as! LaunchpadViewController
            vc.sequence.reset()
            vc.sequenceNotes = vc.sequence.notes
            vc.board.setNotes(notes: notes)
            vc.keyNotes = notes
            vc.collectionView.reloadData()
        }
    }
    
    
    //função para tocar as notas musicais
    func playSound(note: String) {
        let path = Bundle.main.path(forResource: "marimba_nota_" + note, ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print(error)
        }
        
    }
    
    func defineNotas(btn: UIButton, note: Note){
        if btn.isSelected {
            notes.append(note)
        }
    }
    
    
    @IBAction func imprime(_ sender: Any) {
        for note in notes {
            print(note.color)
        }
    }
    
    
}
