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
    
    var fetchedResultController: NSFetchedResultsController<PlayerProgress>!
    var playerProgress: PlayerProgress!
    
    @IBOutlet weak var progressViewPlayer: UIProgressView!
    @IBOutlet weak var lbProgress: UILabel!
    @IBOutlet weak var lbGamePoints: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Note>!
    
    // recebe a sequencia final
    var resultSequence = [Note]()
    var ouvidas = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProgressPlayer()
        
        collectionView.collectionViewLayout = layout()
        sequenceDataSource()

    }
    
    @IBAction func btnNewGame(_ sender: Any) {
        print("novo jogo")
    }
    
    @IBAction func btnHomeScreen(_ sender: Any) {
        //self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func loadProgressPlayer() {
        let fetchRequest: NSFetchRequest<PlayerProgress> = PlayerProgress.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        playerProgress = fetchedResultController.fetchedObjects?.first
        if playerProgress == nil {
            playerProgress = PlayerProgress(context: context)
            playerProgress.level = 0
        }
        
        if ouvidas == 3 {
            lbGamePoints.text = "Pontuação da partida: 5"
        } else if ouvidas == 2 {
            lbGamePoints.text = "Pontuação da partida: 4"
        } else if ouvidas == 1 {
            lbGamePoints.text = "Pontuação da partida: 3"
        } else if ouvidas == 0 {
            lbGamePoints.text = "Pontuação da partida: 2"
        }
        
        // modifica tamanho da ProgressView
        progressViewPlayer.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        progressViewPlayer.progress = playerProgress.points/playerProgress.pointsLevelUp
        
        lbProgress.text = "\(Int(playerProgress.points))/\(Int(playerProgress.pointsLevelUp))"
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
