//
//  LaunchpadViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class LaunchpadViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, UIImage>!
    
    enum Section {
        case sequence
        case button
        case launchpad
    }
    
    // cria um tabuleiro para ser exibido (launchpad)
    var board = Board(size: 4, instrument: "marimba", isLaunchpad: true)
    
    // pega as notas do launchpad para serem manipuladas (didSelect e keyCell)
    var keyNotes = [Note]()
    
    // vetor de imagens das notas para configurar a collection view (snapshot)
    var keyImages:[UIImage]?
    

    
    let sequenceImg: [UIImage] = [UIImage(named: "pinkOn")!,
                                 UIImage(named: "greenOn")!,
                                 UIImage(named: "redOn")!,
                                 UIImage(named: "blueOn")!,
                                 UIImage(named: "delete")!]
    
    let btnImg: [UIImage] = [UIImage(named: "play")!]
    
//    let keyImg: [UIImage] = [UIImage(named: "keyBlueOn")!,
//                             UIImage(named: "keyGreenOn")!,
//                             UIImage(named: "keyRedOn")!,
//                             UIImage(named: "keyPinkOn")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.collectionViewLayout = configLayout()
        
        keyNotes = board.launchpad

        keyImages = board.getKeyImagesLaunchpad()
        
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
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
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
        dataSource = UICollectionViewDiffableDataSource<Section, UIImage>(collectionView: self.collectionView, cellProvider: { (collectionView, IndexPath, image) -> UICollectionViewCell? in
            
            guard let btnDeleteCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseIdentifierDelete, for: IndexPath) as? ButtonCell else { fatalError("Cannot create delete button cell") }
            
            guard let btnCell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseIdentifier, for: IndexPath) as? ButtonCell else { fatalError("Cannot create button cell") }
            
            guard let keyCell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchpadCell.reuseIdentifier, for: IndexPath) as? LaunchpadCell else { fatalError("Cannot create key cell") }
            
//            keyCell.keyOn.image = image
            if IndexPath.section == 2 {
                // atribui nota à celula do launchpad
                let note = self.keyNotes[IndexPath.row]
                keyCell.setNoteKey(note: note)
            }

            if image == UIImage(named: "delete")! {
                return btnDeleteCell
            } else if image == UIImage(named: "play")!  {
                return btnCell
            } else {
                return keyCell
            }
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIImage>()
        snapshot.appendSections([.sequence, .button, .launchpad])
        snapshot.appendItems(sequenceImg, toSection: .sequence)
        snapshot.appendItems(btnImg, toSection: .button)
        snapshot.appendItems(keyImages!, toSection: .launchpad)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}

// MARK: - Delegate

extension LaunchpadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell: \(indexPath[1])")
        print(keyNotes[indexPath[1]].name)
        
        let selectedNote = keyNotes[indexPath[1]]
        
        if selectedNote.image == UIImage(named: "key\(selectedNote.color)Off") {
            selectedNote.turnOn()
            // TODO: Adicionar na sequência
        } else {
            // TODO: chamar essa função ao apertar o botão apagar + retirar da sequência
            selectedNote.turnOff()
        }
        
        collectionView.reloadData()
    }
}
