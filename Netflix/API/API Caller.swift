//
//  API Caller.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/08.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct MoviesApiCalls
{
    static let API_KEY = "8fd18f8b153272d031cc4c563ce1fb81&sort_by=name.asc"
    static let baseUrl_APIKEY = "https://api.themoviedb.org"
    static let YOUTUBE_API_KEY = "AIzaSyCytnwDY8-EnMGF832xB3cTXJnzcC5TZ2w"
    static let youtube_URL = "https://youtube.googleapis.com/youtube"
}

enum APIError: Error
{
    case failtoRetreiveData
}

class APICaller
{
    static let shared = APICaller()
    
    
    
    func getTrendingMovie(completion: @escaping(Result<[Title], Error>) -> Void)
    {
        guard let url = URL(string: "\(MoviesApiCalls.baseUrl_APIKEY)/4/list/1?api_key=\(MoviesApiCalls.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            
            do
            {
                //                  let resutl = try JSONSerialization.jsonObject(with: datatask, options: .fragmentsAllowed)
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
                //                  print(resutl)
                
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
    }
    
    func gettrendingTv(completion: @escaping(Result<[Title], Error>) -> Void)
    {
        guard let url = URL(string: "\(MoviesApiCalls.baseUrl_APIKEY)/4/list/2?api_key=\(MoviesApiCalls.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            
            do
            {
                //                  let resutl = try JSONSerialization.jsonObject(with: datatask, options: .fragmentsAllowed)
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
                //                  print(resutl)
                
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
    }
    
    
    func getPopularMoview(completion: @escaping(Result<[Title], Error>) -> Void)
    {
        guard let url = URL(string: "\(MoviesApiCalls.baseUrl_APIKEY)/4/list/3?api_key=\(MoviesApiCalls.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            
            do
            {
                //                  let resutl = try JSONSerialization.jsonObject(with: datatask, options: .fragmentsAllowed)
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
                //                  print(resutl)
                
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
    }
    
    func getUpComingMovies(completion: @escaping(Result<[Title], Error>)-> Void)
    {
        guard let url = URL(string: "\(MoviesApiCalls.baseUrl_APIKEY)/4/list/4?api_key=\(MoviesApiCalls.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            
            do
            {
                //                  let resutl = try JSONSerialization.jsonObject(with: datatask, options: .fragmentsAllowed)
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
                //                  print(resutl)
                
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
    }
    
    func getAllTopratedMovies(completion: @escaping(Result<[Title], Error>)-> Void)
    {
        guard let url = URL(string: "\(MoviesApiCalls.baseUrl_APIKEY)/4/list/5?api_key=\(MoviesApiCalls.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            
            do
            {
                //                  let resutl = try JSONSerialization.jsonObject(with: datatask, options: .fragmentsAllowed)
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
                //                  print(resutl)
                
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
    }
    
    func searchAndGetMovie(completion: @escaping(Result<[Title], Error>) -> Void)
    {
        
        guard let url=URL(string:"\(MoviesApiCalls.baseUrl_APIKEY)/4/discover/movie?api_key=\(MoviesApiCalls.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            do
            {
                //                  let resutl = try JSONSerialization.jsonObject(with: datatask, options: .fragmentsAllowed)
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
                //                  print(resutl)
                
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
        
        
    }
    
    func searchQuery(with query: String ,completion: @escaping(Result<[Title], Error>) -> Void)
    {
        
        
        guard let Query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(MoviesApiCalls.baseUrl_APIKEY)/4/search/movie?api_key=\(MoviesApiCalls.API_KEY)&query=\(Query)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (Data, _, error) in
            guard let datatask = Data, error == nil else {return}
            
            do
            {
            
                let resutls = try JSONDecoder().decode(TrendingTitleResponse.self, from: datatask)
                completion(.success(resutls.results))
            
            }catch
            {
                completion(.failure(APIError.failtoRetreiveData))
            }
        }
        task.resume()
    }
    
    func getMoviesFromYoutube(with Query: String ,completion: @escaping(Result<Videos, Error>) -> Void)
    {
        guard let myQuery = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let youtubesearch = URL(string: "\(MoviesApiCalls.youtube_URL)/v3/search?q=\(myQuery)&key=\(MoviesApiCalls.YOUTUBE_API_KEY)") else
        {return}
        
        let task = URLSession.shared.dataTask(with: youtubesearch) { (Data, _, error) in
                  guard let datatask = Data, error == nil else {return}
                  
                  do
                  {
                  
//                    let resutls = try JSONSerialization.jsonObject(with: datatask, options: .allowFragments)
                    let youtubeRersult = try JSONDecoder().decode(YouTubeSearchResponse.self, from: datatask)
//                    print(resutls)
                    completion(.success(youtubeRersult.items[0]))
                  
                  }catch
                  {
                    completion(.failure(APIError.failtoRetreiveData))
                  }
              }
              task.resume()
        
    }
    
    func pressButtonToplayPreview(currenttitle: Title , navigationController: UINavigationController)
       {
           APICaller.shared.getMoviesFromYoutube(with: currenttitle.original_name ?? currenttitle.original_title ?? "") {Results in
               switch Results
               {
               case .success(let myAllVideos):
                   DispatchQueue.main.async {
                       let previewmHeaderViewmovie = PreviewMoviesViewController()
                       previewmHeaderViewmovie.configurationModel(with: TitlepreviewModel(title: currenttitle.original_name ?? currenttitle.original_title ?? "", titleOverview: currenttitle.overview ?? "", CurrentMovie: myAllVideos))
                       navigationController.pushViewController(previewmHeaderViewmovie, animated: true)
                   }
               case .failure(let error):
                   print(error.localizedDescription)
               }
           }
       }
    
}


