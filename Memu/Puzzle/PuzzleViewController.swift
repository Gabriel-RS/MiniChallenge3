//
//  PuzzleViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit
import AVFoundation

class PuzzleViewController: UIViewController {

    @IBOutlet weak var ear1: UIImageView!
    @IBOutlet weak var ear2: UIImageView!
    @IBOutlet weak var ear3: UIImageView!
    var ouvidas = Int()
    var launchpadVc = LaunchpadViewController()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnCheck: UIButton!
    
    enum Section {
        case sequence
        case button
        case puzzle
    }
    
    // cria um tabuleiro puzzle para ser exibido e suas notas (do, re, mi, fa)
    var puzzleBoard = Board(size: 4, instrument: "marimba", type: "puzzle")
    var puzzleNotes = [Note]()
    
    // configura a sequencia do puzzle e suas notas
    var sequence = Sequence(size: 4)
    var sequenceNotes = [Note]()
    
    // recebe a sequencia de notas do launchpad
    var launchpadSequence = [Note]()
    
    var board3 = Board(size: 1, instrument: "marimba", type: "puzzle")
    var keyNotes3 = [Note]()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Note>!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.collectionViewLayout = configLayout()
        
        puzzleNotes = puzzleBoard.launchpad
        sequenceNotes = sequence.notes
        
        // seção button
        keyNotes3 = board3.launchpad
        
        configDataSource()
        
        //ouvidas
        ouvidas = 3
    }
    
    // MARK: - Button
    // toca a sequencia criada no launchpad
    @IBAction func btnPlay(_ sender: Any) {
        print("Play Button")
        playLaunchpad()
        
        for note in launchpadSequence {
            if(note.name != "delete") {
                print(note.name)
            }
        }
    }
    
    @IBAction func btnHear(_ sender: Any) {
        
        if ouvidas > 0 {
            switch(ouvidas){
            case 3:
                ear3.image = UIImage(named: "earOff")
                ouvidas -= 1
                play()
                break
            case 2:
                ear2.image = UIImage(named: "earOff")
                ouvidas -= 1
                play()
                break
            case 1:
                ear1.image = UIImage(named: "earOff")
                ouvidas -= 1
                play()
                break
            case 0:
                break
            default:
                break
                
            }
        } else {
            let alert = UIAlertController(title: "Ouvidas", message: "\nVocê já gastou todas as suas ouvidas!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnCheck(_ sender: Any) {
        print("Check Button")
        let sequenceResult: [Note] = generateResultSequence()
        
        if checkVictory(comparedArray: sequenceResult) {
            // se sequencia estiver certa
            performSegue(withIdentifier: "conclusionSegue", sender: self)
        } else {
            // atualiza sequencia do tabuleiro e sequencia conectada à collection view
            sequence.notes = sequenceResult
            sequence.notes.append(Note(name: "delete", soundFile: "", color: "", type: "delete"))
            sequenceNotes = sequenceResult
            sequenceNotes.append(Note(name: "delete", soundFile: "", color: "", type: "delete"))
            
            btnCheck.isEnabled = false
            
            collectionView.reloadData()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conclusionSegue" {
            let vc = segue.destination as! CompletionViewController
            vc.resultSequence = generateResultSequence()
        }
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        print("Menu Button")
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Collection View Layout
    
    func configLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sect = sectionIndex
            
            if sect == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 0, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.1))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 50, bottom: 0, trailing: 50)
                
                return section
    
            } else if sect == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 50, bottom: 0, trailing: 50)
                
                return section
                
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 0, bottom: 5, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50)
                
                return section
            }
        
        }
        
        return layout
    }
    
    // MARK: - Collection View Data Source
    
    func configDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Note>(collectionView: self.collectionView, cellProvider: { (collectionView, IndexPath, image) -> UICollectionViewCell? in

            guard let btnDeleteCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseIdentifierDelete, for: IndexPath) as? ButtonCell else { fatalError("Cannot create delete button cell") }

            guard let btnCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseIdentifier, for: IndexPath) as? ButtonCell else { fatalError("Cannot create button cell") }

            guard let puzzleCell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchpadCell.reuseIdentifier, for: IndexPath) as? LaunchpadCell else { fatalError("Cannot create key cell") }

            if self.sequenceNotes[IndexPath.row].image == UIImage(named: "delete")! {
                btnDeleteCell.delegate = self
                return btnDeleteCell
            } else if IndexPath.section == 1  {
                // botão das ouvidas
                btnCell.delegate = self
                return btnCell
            } else {
                if IndexPath.section == 0 {
                    // se for elemento da sequencia
                    print(IndexPath)
                    puzzleCell.setNoteKey(note: self.sequenceNotes[IndexPath.row])
                    return puzzleCell

                } else {
                    // se for tecla do puzzle
                    let note = self.puzzleNotes[IndexPath.row]
                    puzzleCell.setNoteKey(note: note)
                    return puzzleCell
                }
            }

        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.sequence, .button, .puzzle])
        snapshot.appendItems(sequenceNotes, toSection: .sequence)
        snapshot.appendItems(keyNotes3, toSection: .button)
        snapshot.appendItems(puzzleNotes, toSection: .puzzle)


        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    
    func generateResultSequence() -> Array<Note>{
        var result: [Note] = []
        var count: Int = 0
        
        for launchpadNote in launchpadSequence {
            if launchpadNote.name != "delete" {
                if launchpadNote.name == sequenceNotes[count].name {
                    let rightNote = Note(name: launchpadNote.name, soundFile: launchpadNote.soundFile, color: launchpadNote.color, type: "sequenceOn")
                    result.append(rightNote)
                } else {
                    let wrongNote = Note(name: sequenceNotes[count].name, soundFile: sequenceNotes[count].soundFile, color: sequenceNotes[count].color, type: "invalid")
                    result.append(wrongNote)
                }
                count += 1
            }
        }
        return result
    }
    
    func checkVictory(comparedArray: [Note]) -> Bool {
        for note in comparedArray {
            if note.image == UIImage(named: "seqGrayOn") {
                return false
            }
        }
        return true
    }
    
    
    

}

// MARK: - Delegates

extension PuzzleViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell: \(indexPath[1])")
        
        // se for da seção de tecla
        if indexPath.section == 2  {
            print(puzzleNotes[indexPath[1]].name)
            if puzzleNotes[indexPath[1]].image == UIImage(named: "keyGrayOff") {
                // muda cor da tecla
                puzzleNotes[indexPath[1]].turnOn()
                launchpadVc.playNote(puzzleNotes[indexPath[1]].soundFile)
                // adiciona no array de sequencia
                sequence.addNote(note: puzzleNotes[indexPath[1]])
                // atualiza array de notas da sequencia (conectado à collection)
                self.sequenceNotes = sequence.notes
                
                if sequence.isFull() {
                    btnCheck.isEnabled = true
                }
                
                collectionView.reloadData()
            }
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let keyCell = collectionView.cellForItem(at: indexPath) as? LaunchpadCell {
            keyCell.keyOn.isHighlighted = true
            keyCell.keyOn.alpha = 0.8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let keyCell = collectionView.cellForItem(at: indexPath) as? LaunchpadCell {
            keyCell.keyOn.isHighlighted = false
            keyCell.keyOn.alpha = 1.0
        }
    }
}

extension PuzzleViewController: ButtonCellDelegate {
    func delete() {
        // retira a nota do vetor
        let erasedNote = sequence.eraseNote()
        // atualiza as notas para aparecerem na collection
        self.sequenceNotes = sequence.notes
        
        // acha a nota apagada e desliga ela do launchpad
        for note in puzzleNotes {
            if(note.name == erasedNote.name) {
                note.turnOff()
            }
        }
        
        // se deletar qualquer nota, a sequencia já não vai estar cheia
        btnCheck.isEnabled = false
        
        collectionView.reloadData()
    }
    
    // toca a sequencia criada no puzzle
    func play() {
        for note in sequenceNotes {
            if(note.name != "off" && note.name != "delete") {
                print(note.name)
            }
        }
        
        launchpadVc.prepareToPlay(sequenceNotes: sequenceNotes)
        launchpadVc.sequencePlayer?.seek(to: .zero)
        launchpadVc.sequencePlayer?.play()
    }
    
    func playLaunchpad() {
        for note in sequenceNotes {
            if(note.name != "off" && note.name != "delete") {
                print(note.name)
            }
        }
        
        launchpadVc.prepareToPlay(sequenceNotes: launchpadSequence)
        launchpadVc.sequencePlayer?.seek(to: .zero)
        launchpadVc.sequencePlayer?.play()
    }
    
    
}
