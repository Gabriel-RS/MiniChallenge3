//
//  CompletionViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class CompletionViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Note>!
    
    // recebe a sequencia final
    var resultSequence = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layout()
        sequenceDataSource()

    }
    
    @IBAction func btnNewGame(_ sender: Any) {
        print("novo jogo")
    }
    
    @IBAction func btnHomeScreen(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.25))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func sequenceDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Note>(collectionView: self.collectionView, cellProvider: { (collectionView, IndexPath, image) -> UICollectionViewCell? in
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: SequenceCell.reuseIdentifier, for: IndexPath) as? SequenceCell else {
                fatalError("Cannot create new cell")
            }
            
            cell.setNoteKey(note: self.resultSequence[IndexPath.row])
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.main])
        
        snapshot.appendItems(resultSequence)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

}
