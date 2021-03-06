//
//  CategoryCollectionViewCell.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/16/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit
import AVKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "category-cell-reuse-identifier"
    
    private(set) var category: Category!
    @IBOutlet private weak var contentOutlet: UIView!
    @IBOutlet private weak var titleOutlet: UILabel!
    @IBOutlet private weak var descOutlet: UILabel!
    
    func configure(for category: Category) {
        self.category = category
        titleOutlet.text = category.title
        descOutlet.text = category.desc
        self.contentView.backgroundColor = UIColor(displayP3Red: 100.0 / 255.0, green: 149.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 8
        
        self.contentOutlet.subviews.forEach{ $0.removeFromSuperview()}
        
        if let imageURL = category.coverImage {
            let dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    DispatchQueue.main.async {
                        let img = UIImage(data: data!)
                        let imgView = UIImageView(frame: self.contentView.bounds)
                        imgView.contentMode = .scaleToFill
                        imgView.image = img
                        self.contentOutlet.clipsToBounds = true
                        self.contentOutlet.addSubview(imgView)
                    }
                    
                }
            }
            dataTask.resume()
        }
    }
    
    /*
     func temp() {
     let videoURL = URL(string: "https://sample-videos.com/video123/mp4/360/big_buck_bunny_360p_2mb.mp4")
     let player = AVPlayer(url: videoURL!)
     let playerLayer = AVPlayerLayer(player: player)
     playerLayer.frame = contentOutlet.bounds
     self.contentOutlet.layer.addSublayer(playerLayer)
     player.play()
     }*/
}
