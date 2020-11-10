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
    
    var notesArray: [String] = []
    var aux:Int = 4
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
        defineNotas(btn: btnDo, note: "do")
        defineNotas(btn: btnRe, note: "re")
        defineNotas(btn: btnMi, note: "mi")
        defineNotas(btn: btnFa, note: "fa")
        defineNotas(btn: btnSol, note: "sol")
        defineNotas(btn: btnLa, note: "la")
        defineNotas(btn: btnSi, note: "si")
        performSegue(withIdentifier: "apresentaNotas", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "apresentaNotas"){
            let vc = segue.destination as! checkNotes
            vc.notesArray = notesArray
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
    
    func defineNotas(btn: UIButton, note: String){
        if btn.isSelected {
            notesArray.append(note)
        }
    }
    
    

    
}

class checkNotes: UIViewController {
    
    var notesArray: [String] = []
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    
    override func viewDidLoad() {
        defineNote(btn: btn1, note: notesArray[0])
        defineNote(btn: btn2, note: notesArray[1])
        defineNote(btn: btn3, note: notesArray[2])
        defineNote(btn: btn4, note: notesArray[3])
    }
    
    func defineNote(btn: UIButton, note: String){
        switch(note){
        case "do":
            btn.setImage(UIImage(named: "noteCOff"), for: .normal)
            break
        case "re":
            btn.setImage(UIImage(named: "noteDOff"), for: .normal)
            break
        case "mi":
            btn.setImage(UIImage(named: "noteEOff"), for: .normal)
            break
        case "fa":
            btn.setImage(UIImage(named: "noteFOff"), for: .normal)
            break
        case "sol":
            btn.setImage(UIImage(named: "noteGOff"), for: .normal)
            break
        case "la":
            btn.setImage(UIImage(named: "noteAOff"), for: .normal)
            break
        case "si":
            btn.setImage(UIImage(named: "noteBOff"), for: .normal)
            break
        default:
            break
        }
        
    }
    
    
    @IBAction func backBttn(_ sender: Any) {
       
    }
    
    
    
}




