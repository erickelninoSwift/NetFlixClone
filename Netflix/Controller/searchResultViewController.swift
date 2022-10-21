//
//  searchResultViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/16.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

protocol searchresultsPreviewProtocol: AnyObject {
    func resultsSearchToPreview(_ viewModel: TitlepreviewModel)
}


class searchResultViewController: UIViewController {

    
    
    var delegate:searchresultsPreviewProtocol?
    
    
    public var AllmyTitles:[Title] = [Title]()
    
    public let collectionViewResutls: UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 5, height: 200)
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        return collection
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(collectionViewResutls)
        
        collectionViewResutls.delegate = self
        collectionViewResutls.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewResutls.frame = view.bounds
    }
  

}

extension searchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return AllmyTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else
        {
            return UICollectionViewCell()
        }
        let currentData = AllmyTitles[indexPath.row].poster_path
        cell.setImage(with: currentData ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let currentTitle = AllmyTitles[indexPath.row]
        
        guard let searchTitle = currentTitle.original_title ?? currentTitle.original_name else
        {return}
        
        APICaller.shared.getMoviesFromYoutube(with: "\(searchTitle) trailer") { [weak self] Result in
            DispatchQueue.main.async {
                switch Result
                {
                case .success(let AllmyVideos):
                    
                    self?.delegate?.resultsSearchToPreview(TitlepreviewModel(title: currentTitle.original_name ?? currentTitle.original_title ?? "", titleOverview: currentTitle.overview ?? "", CurrentMovie: AllmyVideos))
                    case . failure(let Error):
                    print(Error.localizedDescription)
                }
            }
        }
        
    }
}
