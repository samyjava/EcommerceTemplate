//
//  ItemCollectionViewCell.swift
//  EcommerceTemplate
//
//  Created by Sam Javadizadeh on 2/25/20.
//  Copyright © 2020 Sam Javadizadeh. All rights reserved.
//

import UIKit
import AVKit

class ItemCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "item-cell-reuse-identifier"
    private(set) var item: Item!
    
    private var mediaView: UIView!
    private var descLabel: UILabel!
    private var priceLabel: UILabel!
    private var beforeDiscountPriceLabel: UILabel!
    private var inStockCountLabel: UILabel!
    
    func configure(for item: Item) {
        configureHierarchy()
        descLabel.text = item.desc
        
        if let price = item.price, price.count > 0 {
            priceLabel.text = price + " $"
        }
        
        if let price = item.beforeDiscountPrice, price.count > 0 {
            let discountPriceString = price + " $"
            let attString = NSMutableAttributedString(string: discountPriceString)
            attString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: discountPriceString.count))
            beforeDiscountPriceLabel.attributedText = attString
        }
        
        
        if item.inStockCount < 10 {
            inStockCountLabel.text = "only \(item.inStockCount) left in stock"
        }
        
        if item.status == 1 {
            putUnavailable(text: "Un-Available")
        }
        
        if let imageURL = item.coverImage {
            putImage(url: imageURL)
        }
        
        if let videoURL = item.coverVideo {
            putVideo(url: videoURL)
        }
    }
    
    private func configureHierarchy() {
        
        //config content view
        contentView.backgroundColor = .white
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        //config media view
        mediaView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.height / 2))
        mediaView.translatesAutoresizingMaskIntoConstraints = false
        // config desc label
        descLabel = UILabel()
        self.contentView.addSubview(descLabel)
        descLabel.textAlignment = .left
        descLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        descLabel.adjustsFontSizeToFitWidth = true
        descLabel.numberOfLines = 0
        
        
        //config price label
        priceLabel = UILabel()
        priceLabel.textAlignment = .left
        priceLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        priceLabel.minimumScaleFactor = 0.4
        
        //config beforeDiscountPrice label
        beforeDiscountPriceLabel = UILabel()
        beforeDiscountPriceLabel.textAlignment = .left
        beforeDiscountPriceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        beforeDiscountPriceLabel.minimumScaleFactor = 0.4
    
        //config inStockCount Label
        inStockCountLabel = UILabel()
        inStockCountLabel.textAlignment = .right
        inStockCountLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        inStockCountLabel.minimumScaleFactor = 0.4
        inStockCountLabel.textColor = .systemRed
        
        //config stack views
        let priceStack = UIStackView(arrangedSubviews: [priceLabel,beforeDiscountPriceLabel])
        priceStack.axis = .horizontal
        priceStack.alignment = .bottom
        priceStack.distribution = .fill
        priceStack.spacing = 10
        
        let bottomStack = UIStackView(arrangedSubviews: [priceStack, inStockCountLabel])
        bottomStack.axis = .vertical
        bottomStack.alignment = .leading
        bottomStack.distribution = .fill
        
        let stackView = UIStackView(arrangedSubviews: [mediaView,descLabel,bottomStack])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        self.contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            stackView.heightAnchor.constraint(equalTo: mediaView.heightAnchor, multiplier: 2),
            stackView.heightAnchor.constraint(equalTo: bottomStack.heightAnchor, multiplier: 6)
        ])
    }
    
    private func putImage(url: URL) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    let img = UIImage(data: data!)
                    let imgView = UIImageView(frame: self.mediaView.bounds)
                    imgView.contentMode = .scaleToFill
                    imgView.image = img
                    self.mediaView.insertSubview(imgView, at: 0)
                    imgView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        imgView.topAnchor.constraint(equalTo: self.mediaView.topAnchor),
                        imgView.leadingAnchor.constraint(equalTo: self.mediaView.leadingAnchor),
                        imgView.trailingAnchor.constraint(equalTo: self.mediaView.trailingAnchor),
                        imgView.bottomAnchor.constraint(equalTo: self.mediaView.bottomAnchor)
                    ])
                }
                
            }
        }
        dataTask.resume()
    }
    
    private func putVideo(url: URL){
        DispatchQueue.global(qos: .userInitiated).async {
            
            let player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            
            DispatchQueue.main.async {
                let tempView = UIView(frame: CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height / 2))
                NSLayoutConstraint.activate([
                    tempView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
                    tempView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
                ])
                playerLayer.videoGravity = .resizeAspectFill
                playerLayer.frame = tempView.bounds
                self.contentView.addSubview(tempView)
                NSLayoutConstraint.activate([
                    tempView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                    tempView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
                    tempView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
                ])
                player.play()
            }
        }
    }
    
    private func putUnavailable(text: String) {
        let unAvailableView = UIView(frame: contentView.bounds)
        let tempView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        let label = UILabel(frame: tempView.bounds)
        unAvailableView.backgroundColor = .systemBackground
        unAvailableView.alpha = 0.5
        unAvailableView.addSubview(tempView)
        unAvailableView.isUserInteractionEnabled = false
        tempView.addSubview(label)
        tempView.backgroundColor = .systemRed
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.minimumScaleFactor = 0.4
        label.textColor = .white
        label.text = text
        
        self.contentView.addSubview(unAvailableView)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: tempView.topAnchor),
            label.leadingAnchor.constraint(equalTo: tempView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: tempView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: tempView.bottomAnchor),
            tempView.topAnchor.constraint(equalTo: unAvailableView.topAnchor, constant: 20),
            tempView.leadingAnchor.constraint(equalTo: unAvailableView.leadingAnchor),
            unAvailableView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            unAvailableView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            unAvailableView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            unAvailableView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
    }
}

extension ItemCollectionViewCell {
    override func prepareForReuse() {
        contentView.subviews.forEach{ $0.removeFromSuperview()}
    }
}
