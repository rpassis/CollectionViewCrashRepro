//
//  ViewController.swift
//  CollectionViewCrashTest
//
//  Created by Rogerio de Paula Assis on 4/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private var datasource: DataSource!
    private var collectionViewUpdatesTimer: Timer!
    private var backgroundModifierTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource = DataSource()
        collectionView.dataSource = datasource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// Keeps updating the collection view datasource and performing batch updates
        collectionViewUpdatesTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            self.collectionView.performBatchUpdates({
                self.datasource.items.remove(at: 0)
                self.collectionView.deleteItems(at: [IndexPath(row: 0, section: 0)])
            }, completion: { done in
                print("Done: \(done)")
            })
        })
        
        /// Modifies the underlying video storage in a backgroudn thread, while the collection view is updating
        backgroundModifierTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            DispatchQueue.global().async {
                let video = Video()
                VideoProvider.shared.videos.append(video)
            }
        })
    }
}

class VideoCell: UICollectionViewCell {
    
    @IBOutlet var videoLabel: UILabel!
    
    var video: Video? {
        didSet { updateCell() }
    }
    
    private func updateCell() {
        videoLabel.text = video?.uuid.uuidString
    }
}
