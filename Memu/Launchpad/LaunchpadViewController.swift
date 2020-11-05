//
//  LaunchpadViewController.swift
//  Memu
//
//  Created by Gabriel Rodrigues da Silva on 03/11/20.
//

import UIKit

class LaunchpadViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum Section {
        case sequence
        case button
        case launchpad
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self

    }
    
//    func configLayout() -> UICollectionViewCompositionalLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//            
//            
//        }
//        return layout
//    }
    
    func configDataSource() {
        
    }

}

// MARK: - Delegate

extension LaunchpadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
