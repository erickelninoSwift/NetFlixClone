//
//  SearchViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit


class SearchViewController: UIViewController , UISearchBarDelegate {
    
    private var AllTitles:[Title] = [Title]()
    
    private let searchUItableView: UITableView =
    {
        let tableview = UITableView()
        tableview.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.CELL_ID)
        
        return tableview
    }()
    
    private let searchbarViewController: UISearchController =
    {
        let controller = UISearchController(searchResultsController: searchResultViewController())
        controller.searchBar.placeholder = "Search for Movie here"
        controller.searchBar.searchBarStyle = .minimal
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barTintColor = .systemBackground
        getMovieRequested()
        configureTableUIView()
        
        searchbarViewController.searchBar.delegate = self
        searchbarViewController.searchResultsUpdater = self
        searchbarViewController.searchBar.tintColor = .white
        searchbarViewController.searchResultsUpdater = self
        
    }
    
    
    
    private func getMovieRequested()
    {
        APICaller.shared.searchAndGetMovie {[weak self] Result in
            switch Result
            {
            case .success(let titlesErick):
                self?.AllTitles = titlesErick
                DispatchQueue.main.async {
                    self?.searchUItableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    func configureTableUIView()
    {
        
        searchUItableView.delegate = self
        searchUItableView.dataSource = self
        navigationItem.searchController = searchbarViewController
        view.addSubview(searchUItableView)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchUItableView.frame = view.bounds
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.CELL_ID, for: indexPath) as? TitleTableViewCell else
        {
            return UITableViewCell()
        }
        
        let listoftitle = TitleModel(url: AllTitles[indexPath.row].poster_path ?? "Unknown" , MovieTitle: AllTitles[indexPath.row].original_name ?? AllTitles[indexPath.row].original_title ?? "Unknown")
        cell.playButton.isHidden = true
        cell.configureCellmodel(with: listoftitle)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        searchUItableView.deselectRow(at: indexPath, animated: true)
        let selectedtitle = AllTitles[indexPath.row]
              
              guard let TitleName = selectedtitle.original_title ?? selectedtitle.original_name else {return}
              
              APICaller.shared.getMoviesFromYoutube(with: TitleName) {[weak self] Result in
                  switch Result
                  {
                  case .success(let myAllvidoes):
                      DispatchQueue.main.async {
                          let previewcontroller = PreviewMoviesViewController()
                          previewcontroller.configurationModel(with: TitlepreviewModel(title:selectedtitle.original_title ?? selectedtitle.original_title ?? "" , titleOverview: selectedtitle.overview ?? "", CurrentMovie: myAllvidoes))
                          self?.navigationController?.pushViewController(previewcontroller, animated: true)
                      }
                  case .failure(let error):
                      print(error.localizedDescription)
                  }
              }
        
    }
}

extension SearchViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchbarViewController.searchBar
        guard let Myquery = searchBar.text , !Myquery.trimmingCharacters(in: .whitespaces).isEmpty,
            Myquery.trimmingCharacters(in: .whitespaces).count >= 3 else {return}
        
        guard let Myresults = searchController.searchResultsController as? searchResultViewController else
        {return}
        Myresults.delegate = self
        APICaller.shared.searchQuery(with: Myquery) { Results in
            DispatchQueue.main.async
                {
                    switch Results
                    {
                    case .success(let TitlesOnes):
                        Myresults.AllmyTitles = TitlesOnes
                        Myresults.collectionViewResutls.reloadData()
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
            }
        }
    }
}

extension SearchViewController: searchresultsPreviewProtocol
{
    func resultsSearchToPreview(_ viewModel: TitlepreviewModel) {
        DispatchQueue.main.async {
            let previewcontroller = PreviewMoviesViewController()
            previewcontroller.configurationModel(with: viewModel)
            self.navigationController?.pushViewController(previewcontroller, animated: true)
        }
    }
    
}
