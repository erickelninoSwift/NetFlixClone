//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/02.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import CoreData

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidtapCell(_ cell: CollectionViewTableViewCell , previewModel: TitlepreviewModel)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    
    static let NOTIFICATION_NAME = "Downloaded"
    
    weak var delegate:CollectionViewTableViewCellDelegate?
    
    
    var myTitle:[Title] = [Title]()
    
    
    
    static let identifier = "CollectionViewTableViewCell"
    
    fileprivate let mycollectionView: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 200)
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mycollectionView)
        mycollectionView.delegate = self
        mycollectionView.dataSource = self
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mycollectionView.frame = contentView.bounds
    }
    
    
    
    func setTitle(with Titles:[Title])
    {
        myTitle = Titles
        DispatchQueue.main.async {[weak self] in
            
            self?.mycollectionView.reloadData()
        }
    }
    
//    COREDATA DOWNLOAD FLOW
    
    
    private func downloadTitle(myIndexPath: IndexPath)
    {
        print("Download \(myTitle[myIndexPath.row].original_title ?? "There was no title")")
        
        CoredataManager.shared.downloadTitle(viewmodel: myTitle[myIndexPath.row]) {Result in
            switch Result
            {
            case .success(()):
                NotificationCenter.default.post(name: NSNotification.Name("\(CollectionViewTableViewCell.NOTIFICATION_NAME)"), object: nil)
            case .failure(_):
                print("There was an Error")
            }}
        
    }
  
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()
            
        }
        guard let model = myTitle[indexPath.row].poster_path else {
            return UICollectionViewCell()
            
        }
        //        collectionCell.setImageCove(ImagetoCover: model)
        collectionCell.setImage(with: model)
        return collectionCell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let currentTitle = myTitle[indexPath.row]
        
        guard let searchTitle = currentTitle.original_title ?? currentTitle.original_name else
        {return}
        
        APICaller.shared.getMoviesFromYoutube(with: "\(searchTitle) trailer") {[weak self] Result in
            DispatchQueue.main.async {
                switch Result
                {
                case .success(let MyVideso):
                    guard let viewcontrollerself = self else {return}
                    
                    viewcontrollerself.delegate?.CollectionViewTableViewCellDidtapCell(viewcontrollerself, previewModel: TitlepreviewModel(title: currentTitle.original_title ?? currentTitle.original_name ?? "", titleOverview: currentTitle.overview ?? "", CurrentMovie: MyVideso))
                    
                case . failure(let Error):
                    print(Error.localizedDescription)
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let myConfiguration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self](_) -> UIMenu? in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { (_) in
                self?.downloadTitle(myIndexPath: indexPath)
            }
            return UIMenu(title:"", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return myConfiguration
    }
    
}
