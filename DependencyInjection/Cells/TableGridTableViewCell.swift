//
//  TableGridTableViewCell.swift
//  DependencyInjection
//
//  Created by Alfian Losari on 27/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

class TableGridTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var screenshotURLs: [URL] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameThumbnailCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let imageWidth: CGFloat = 160
        let ratioMultiplier = 107.0 / imageWidth
        let containerWidth = UIScreen.main.bounds.width
        
        let itemCount = containerWidth / imageWidth
        let itemWidth = imageWidth * (itemCount / ceil(itemCount))
        let itemHeight = ratioMultiplier * itemWidth
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0


    }


}


extension TableGridTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return screenshotURLs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameThumbnailCell
        let url = screenshotURLs[indexPath.item]
        cell.configure(url)
        
        return cell
    }
    
    
    
}
