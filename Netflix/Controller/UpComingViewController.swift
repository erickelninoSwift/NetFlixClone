//
//  UpComingViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class UpComingViewController: UIViewController {
    
    
    private var AllTitles:[Title] = [Title]()
    
    private let upComingTable: UITableView =
    {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.CELL_ID)
     
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Upcoming"

      
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.barTintColor = .systemBackground
        upComingTable.delegate = self
        upComingTable.dataSource = self
        
        view.addSubview(upComingTable)
        upComingTable.tableFooterView = UIView()
        getAllupComingMovies()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upComingTable.frame = view.bounds
        view.backgroundColor = .black
    }
    
    
    func getAllupComingMovies()
    {
        APICaller.shared.getUpComingMovies { [weak self] Result in
            switch Result
            {
            case .success(let titles):
                self?.AllTitles = titles
                
                DispatchQueue.main.async {
                    self?.upComingTable.reloadData()
                }
            case .failure(let error):
                print("There was an Error while trying to retreive data \(error.localizedDescription)")
            }
        }
        
    }
    
}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.CELL_ID, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
            
        }
        let myModel = TitleModel(url: AllTitles[indexPath.row].poster_path ?? "Unknown", MovieTitle: AllTitles[indexPath.row].original_title ?? AllTitles[indexPath.row].original_name ?? "Unknown")
        cell.configureCellmodel(with: myModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
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
