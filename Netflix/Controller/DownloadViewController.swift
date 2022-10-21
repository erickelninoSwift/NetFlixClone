//
//  DownloadViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController {
    
    
    private var AllmyTitles:[TitleItems] = [TitleItems]()
    
    private let DownloadMovies: UITableView =
    {
        let tableview = UITableView()
        tableview.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.CELL_ID)
        
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllerHeaderTitle(mytitle: "Downloads")
        view.backgroundColor = .systemBackground
        
        view.addSubview(DownloadMovies)
        DownloadMovies.delegate = self
        DownloadMovies.dataSource = self
        NotificationCenter.default.addObserver(forName: NSNotification.Name(CollectionViewTableViewCell.NOTIFICATION_NAME), object: nil, queue: nil) { (_) in
            self.fetchLocalStorageFromDownload()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DownloadMovies.frame = view.bounds
        DownloadMovies.tableFooterView = UIView()
    }
}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllmyTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.CELL_ID, for: indexPath) as? TitleTableViewCell
            else
        {
            return UITableViewCell()
        }
        let selectedMovies = AllmyTitles[indexPath.row]
        cell.playButton.isHidden = true
        cell.configureCellmodel(with: TitleModel(url: selectedMovies.poster_path ?? "", MovieTitle: selectedMovies.original_name ?? selectedMovies.original_title ?? ""))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DownloadMovies.deselectRow(at: indexPath, animated: true)
        let Mytitle = AllmyTitles[indexPath.row]
        guard let selectedTitle = Mytitle.original_name ?? Mytitle.original_title else {return}
        
        APICaller.shared.getMoviesFromYoutube(with: selectedTitle) { [weak self] Result in
            switch Result
            {
            case .success(let myVideos):
                DispatchQueue.main.async {
                    let previewViewController = PreviewMoviesViewController()
                    previewViewController.configurationModel(with: TitlepreviewModel(title: selectedTitle, titleOverview: Mytitle.overview ?? "", CurrentMovie: myVideos))
                    self?.navigationController?.pushViewController(previewViewController, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle
        {
        case .delete:
            CoredataManager.shared.deleteItemFromStorage(viewmodel: AllmyTitles[indexPath.row]) { [weak self] Result in
                switch Result
                {
                case .success():
                    print("Data was deleted successfully")
                    self?.AllmyTitles.remove(at: indexPath.row)
                    self?.DownloadMovies.deleteRows(at: [indexPath], with: .fade)
                     self?.DownloadMovies.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            break;
        }
    }
    
    func fetchLocalStorageFromDownload()
    {
        CoredataManager.shared.fetchAllmoviesDownloaded {[weak self]Result in
            switch Result
            {
            case .success(let titles):
                print(titles)
                DispatchQueue.main.async {
                     self?.AllmyTitles = titles
                    self?.DownloadMovies.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
