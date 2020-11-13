//
//  LaunchpadViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class LaunchpadViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Note>!
    
    enum Section: Hashable {
        case sequence
        case button
        case launchpad
    }
    
    // cria um tabuleiro para ser exibido (launchpad) e suas notas
    var board = Board(size: 4, instrument: "marimba", type: "launchpad")
    var keyNotes = [Note]()
    
    // configura a sequencia e suas notas
    var sequence = Sequence(size: 4)
    var sequenceNotes = [Note]()
    
    
    // seção button
    var board3 = Board(size: 1, instrument: "marimba", type: "launchpad")
    var keyNotes3 = [Note]()
    
    
    let btnImg: [UIImage] = [UIImage(named: "play")!]
    
    static var locked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.collectionViewLayout = configLayout()

        keyNotes = board.launchpad
        sequenceNotes = sequence.notes
        
        // seção button
        keyNotes3 = board3.launchpad
        
        configDataSource()
    }
    
    // MARK: - Button
    
    @IBAction func btnMenu(_ sender: Any) {
        print("Menu Button")
    }
    @IBAction func btnNotes(_ sender: Any) {
        print("Notes Button")
    }
    @IBAction func btnCheck(_ sender: Any) {
        print("Check Button")
    }
    
    func getSequenceNotes() -> [Note]{
        return self.sequenceNotes
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
            
            guard let keyCell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchpadCell.reuseIdentifier, for: IndexPath) as? LaunchpadCell else { fatalError("Cannot create key cell") }
            
            if self.sequenceNotes[IndexPath.row].image == UIImage(named: "delete")! {
                btnDeleteCell.delegate = self
                return btnDeleteCell
            } else if IndexPath.section == 1  {
                return btnCell
            } else {
                // se for seção da sequencia
                if IndexPath.section == 0 {
                    print(IndexPath)
                    let sequenceNote = self.sequenceNotes[IndexPath.row]
                    keyCell.setNoteKey(note: sequenceNote)
                    return keyCell

                }else {
                    // se for seção do tabuleiro/launchpad
                    let note = self.keyNotes[IndexPath.row]
                    keyCell.setNoteKey(note: note)
                    return keyCell
                }
            }

        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.sequence, .button, .launchpad])
        snapshot.appendItems(sequenceNotes, toSection: .sequence)
        snapshot.appendItems(keyNotes3, toSection: .button)
        snapshot.appendItems(keyNotes, toSection: .launchpad)
        
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}

// MARK: - Delegate

extension LaunchpadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell: \(indexPath[1])")
//        print(keyNotes[indexPath[1]].name)
        
        let selectedNote = keyNotes[indexPath[1]]
        
        if indexPath.section == 2 && LaunchpadViewController.locked == false {
            if selectedNote.image == UIImage(named: "key\(selectedNote.color)Off") {
                // muda cor da tecla
                selectedNote.turnOn()
                
                // adiciona no array de sequencia
                sequence.addNote(note: selectedNote)
                // atualiza array de notas da sequencia (conectado à collection)
                self.sequenceNotes = sequence.notes
            }
        }
        
        collectionView.reloadData()
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


extension LaunchpadViewController: ButtonCellDelegate {
    func delete() {
        // retira a nota do vetor
        let erasedNote = sequence.eraseNote()
        // atualiza as notas para aparecerem na collection
        self.sequenceNotes = sequence.notes
        // TODO: ATUALIZAR LAUNCHPAD
        
        collectionView.reloadData()
    }
}
