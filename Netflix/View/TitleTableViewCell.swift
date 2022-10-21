//
//  TitleTableViewCell.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/15.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    
    static let CELL_ID = "TitleTableViewCell"
    
    
     let playButton: UIButton =
    {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    private var TitlePosterImageView: UIImageView =
    {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
       
        return image
    }()
    
    
    private let titleLabel: UILabel =
    {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        ApplyContraints()
    }
    
    
    func addViews()
    {
        contentView.addSubview(TitlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
    }
    
    
    func ApplyContraints()
    {
        let titleImageContraints = [TitlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
                                    TitlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                                    TitlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                                    TitlePosterImageView.widthAnchor.constraint(equalToConstant: 70),
                                    TitlePosterImageView.heightAnchor.constraint(equalToConstant: 70)
        ]
        
        let textlabelContrainst = [titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                   titleLabel.leadingAnchor.constraint(equalTo: TitlePosterImageView.trailingAnchor, constant: 25)
                                   
        ]
        
        
        let playButtonConstraints = [playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                                      playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
                                     
            
        ]
        
        NSLayoutConstraint.activate(titleImageContraints)
        NSLayoutConstraint.activate(textlabelContrainst)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    
    
    func configureCellmodel(with Model: TitleModel)
    {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(Model.url)") else {return}
        
        TitlePosterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = Model.MovieTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
