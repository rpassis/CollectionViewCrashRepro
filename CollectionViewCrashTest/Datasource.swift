//
//  Datasource.swift
//  CollectionViewCrashTest
//
//  Created by Rogerio de Paula Assis on 4/11/19.
//  Copyright © 2019 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import UIKit

class Video {
    let uuid = UUID()
}

class VideoProvider {
    static let shared = VideoProvider()
    var videos: [Video] = (0..<100).map { _ in Video() }
}

class DataSource: NSObject, UICollectionViewDataSource {
    
    var items: [Video] {
        get {
            return VideoProvider.shared.videos
        }
        set {
            VideoProvider.shared.videos = newValue
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        let video = items[indexPath.row]
        cell.video = video
        return cell
    }
    
}
