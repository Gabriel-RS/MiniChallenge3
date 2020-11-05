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
    var dataSource: UICollectionViewDiffableDataSource<Section, UIImage>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = layout()
        sequenceDataSource()

    }
    
    @IBAction func btnHomeScreen(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        dataSource = UICollectionViewDiffableDataSource<Section, UIImage>(collectionView: self.collectionView, cellProvider: { (collectionView, IndexPath, image) -> UICollectionViewCell? in
            guard let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: SequenceCell.reuseIdentifier, for: IndexPath) as? SequenceCell else {
                fatalError("Cannot create new cell")
            }
            
            cell.image.image = image
            
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, UIImage>()
        snapshot.appendSections([.main])
        let img: [UIImage] = [UIImage(named: "blueOn")!, UIImage(named: "greenOn")!, UIImage(named: "yellowOn")!, UIImage(named: "redOn")!]
        snapshot.appendItems(img)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
