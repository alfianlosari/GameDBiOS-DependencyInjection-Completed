//
//  GameThumbnailCell.swift
//  DependencyInjection
//
//  Created by Alfian Losari on 27/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit
import Kingfisher

class GameThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }

    func configure(_ imageURL: URL?, contentMode: UIView.ContentMode = .scaleAspectFill ) {
        guard let coverURL = imageURL else {
            return
        }
        
        thumbnailImageView.contentMode = contentMode
        thumbnailImageView.kf.setImage(with: coverURL)
    }

}
