//
//  TitleCollectionViewCell.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/10.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import SDWebImage


class TitleCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier = "TitleCollectionViewCell"
    
     let coverImage: UIImageView =
    {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(coverImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverImage.frame = contentView.bounds
    }
    
    func setImage(with ImageString:String)
    {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(ImageString)") else {return}
        print(url)
        coverImage.sd_setImage(with: url, completed: nil)
    }
}
