//
//  HomeViewController.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/01.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit


enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case Toprated = 4
}

class HomeViewController: UIViewController
{
    fileprivate let CELL_ID = "Home_cell"
    
    
    fileprivate var randomTrandingMoviews: Title?
    fileprivate var headerViewImage: HeroHeaderUIView?
    
    
    
    let sectionTitle: [String] = ["Trending Movies","Trending Tv","Popular","Upcoming Movies","Top rated"]
    
    fileprivate var Hometable: UITableView =
    {
        let table = UITableView(frame: .zero, style:.grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .systemBackground
        
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Hometable.delegate = self
        Hometable.dataSource = self
        addTableTotheView()
        
        Hometable.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        view.backgroundColor = .systemBackground
       configureHeader()
        configureNavigationBar()
        AllMoviesType()

    }


    func configureHeader()
    {
        headerViewImage = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 550))
        
        Hometable.tableHeaderView = headerViewImage
        configureHeaderViewRandome()
    }
    
    func configureHeaderViewRandome()
    {
        APICaller.shared.gettrendingTv {[weak self] Result in
            switch Result
            {
            case .success(let mytitles):
                let myselectedTitle = mytitles.randomElement()
                self?.randomTrandingMoviews = myselectedTitle
                self?.headerViewImage?.configurationHeroHeaderView(with: TitleModel(url: self?.randomTrandingMoviews?.poster_path ?? "", MovieTitle: self?.randomTrandingMoviews?.original_name ?? self?.randomTrandingMoviews?.original_title ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Hometable.frame = view.bounds
    }
    
    
    func addTableTotheView()
    {
        view.addSubview(Hometable)
        Hometable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        Hometable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        Hometable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        Hometable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
    fileprivate func trendingMovies()
    {
        APICaller.shared.getTrendingMovie { (Results) in
            switch Results
            {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    fileprivate func TvseriesTrending()
    {
        APICaller.shared.gettrendingTv { (Results) in
            
            switch Results
            {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription) 
            }
        }
    }
    
    fileprivate func upcoming()
      {
          APICaller.shared.getUpComingMovies { (Results) in
              
              switch Results
              {
              case .success(let movies):
                  print(movies)
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }
    
    
    fileprivate func toprated()
      {
          APICaller.shared.getAllTopratedMovies { (Results) in
              
              switch Results
              {
              case .success(let movies):
                  print(movies)
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }
    
    fileprivate func getAllpopular()
      {
        APICaller.shared.getPopularMoview { (Results) in
              
              switch Results
              {
              case .success(let movies):
                  print(movies)
              case .failure(let error):
                  print(error.localizedDescription)
              }
          }
      }
    
    
    
    
    //    Navigation bar
    
    func configureNavigationBar()
    {
        configureUIBackground()
        
        
        let containerView = UIControl(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        
        let logo = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        logo.image = UIImage(named: "logoCholoNetflix")
        
        containerView.addSubview(logo)
        containerView.addTarget(self, action: #selector(handleLogo), for: .touchUpInside)
        let logoImageButton = UIBarButtonItem(customView: containerView)
        
        logoImageButton.width = 25
        
        navigationItem.leftBarButtonItem = logoImageButton
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person")!.withTintColor(.white, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(handleProfile)),UIBarButtonItem(image: UIImage(systemName: "play.rectangle")!.withTintColor(.white, renderingMode: .alwaysOriginal), style: .done, target: self, action: nil)
        ]
        
//        navigationController?.navigationBar.tintColor = .white
    }
    
    
    @objc func handleLogo()
    {
        print("DEBUG: HELLO WORLD")
    }
    
    @objc func handleProfile()
    {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
         
        cell.delegate = self
        switch indexPath.section {
            
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovie { (Results) in
                switch Results
                {
                case .success(let titles):
                    cell.setTitle(with: titles)
                    
                case .failure(let Error):
                    print(Error.localizedDescription)
                }
                
            }
            
        case Sections.TrendingTv.rawValue:
            
            APICaller.shared.gettrendingTv { (Results) in
                switch Results
                {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMoview { (Results) in
                switch Results
                {
                case .success(let title):
                    cell.setTitle(with: title)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpComingMovies { (Resluts) in
                switch Resluts
                {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error):
                    
                    print(error.localizedDescription)
                }
            }
        case Sections.Toprated.rawValue:
            APICaller.shared.getAllTopratedMovies { (Results) in
                switch Results
                {
                case .success(let titles):
                    cell.setTitle(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
       
        default:
            return UITableViewCell()
        }
            
             return cell
        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    

    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizedFirstLeter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        Hometable.deselectRow(at: indexPath, animated: true)
      
    }
    
}

// ALL Function regarding Movies Type to Top rated

extension HomeViewController
{
    func AllMoviesType()
    {
        trendingMovies()
        TvseriesTrending()
        upcoming()
        toprated()
        getAllpopular()
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate
{
    func CollectionViewTableViewCellDidtapCell(_ cell: CollectionViewTableViewCell, previewModel: TitlepreviewModel) {
        DispatchQueue.main.async {
            let vc = PreviewMoviesViewController()
            vc.configurationModel(with: previewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
