//
//  CompletionViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit
import CoreData

class CompletionViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    enum Section {
        case main
    }
    
    // MARK: - Properties
    var playerManager = PlayerManager.shared
    var dataSource: UICollectionViewDiffableDataSource<Section, Note>!
    // recebe a sequencia final
    var resultSequence = [Note]()
    var ouvidas = Int()
    
    // MARK: - IBOutlets
    @IBOutlet weak var pvPlayer: UIProgressView!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var lbGamePoints: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadInfos()
                
        collectionView.collectionViewLayout = layout()
        sequenceDataSource()
    }
    
    @IBAction func btnNewGame(_ sender: Any) {
        print("novo jogo")
    }
    
    @IBAction func btnHomeScreen(_ sender: Any) {
        //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func loadInfos() {
        if ouvidas == 3 {
            lbGamePoints.text = NSLocalizedString("gameScore5", comment: "Score")
        } else if ouvidas == 2 {
            lbGamePoints.text = NSLocalizedString("gameScore4", comment: "Score")
        } else if ouvidas == 1 {
            lbGamePoints.text = NSLocalizedString("gameScore3", comment: "Score")
        } else if ouvidas == 0 {
            lbGamePoints.text = NSLocalizedString("gameScore2", comment: "Score")
        }
        
        // modifica tamanho da ProgressView
        pvPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        pvPlayer.progress = playerManager.player.points/playerManager.player.pointsLevelUp
        lbProgress.text = "\(Int(playerManager.player.points))/\(Int(playerManager.player.pointsLevelUp))"
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

//extension RewardsViewController: NSFetchedResultsControllerDelegate {
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//
//    }
//}
