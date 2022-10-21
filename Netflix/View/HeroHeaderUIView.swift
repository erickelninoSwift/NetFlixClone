//
//  HeroHeaderUIView.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/02.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import SDWebImage

class HeroHeaderUIView: UIView {
    
    
    private let playbutton: UIButton =
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.layer.cornerRadius = 3
        return button
    }()
    
    private let downloadButton: UIButton =
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.layer.cornerRadius = 3
        return button
    }()
    
     let heroImageView: UIImageView =
    {
        let myimage = UIImageView()
        myimage.clipsToBounds = true
//        myimage.image = UIImage(named: "jackpot")
        return myimage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(heroImageView)
        addgradient()
        self.addSubview(playbutton)
        self.addSubview(downloadButton)
        applyConstraint()
         
    }
    
    
    func applyConstraint()
    {
        NSLayoutConstraint.activate([playbutton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
                                     playbutton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                                     downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
                                     downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)])
    }
    
    
    func addgradient()
    {
        let layergradient = CAGradientLayer()
        layergradient.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        layergradient.frame = self.bounds
        layer.addSublayer(layergradient)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        heroImageView.frame = bounds
    }
    
    
    public func configurationHeroHeaderView(with Model: TitleModel)
       {
           guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(Model.url)") else {return}
           
           heroImageView.sd_setImage(with: url, completed: nil)
    
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
