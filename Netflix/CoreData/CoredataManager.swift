//
//  CoredataManager.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/20.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import CoreData

enum DatabaseError: Error
{
    case FailedToloadData
    case FailedToFetchData
    case FailedTodeleteData
}

class CoredataManager
{
    
    static let shared = CoredataManager()
    
    func downloadTitle(viewmodel: Title, completion: @escaping(Result<Void,Error>) -> Void)
    {
        guard let myAppdelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return 
        }
        let Context = myAppdelegate.persistentContainer.viewContext
        
        let item = TitleItems(context: Context)
        item.id = Int64(viewmodel.id)
        item.media_type = viewmodel.media_type
        item.original_name = viewmodel.original_name
        item.original_title = viewmodel.original_title
        item.overview = viewmodel.overview
        item.poster_path = viewmodel.poster_path
        item.release_date = viewmodel.release_date
        item.vote_count = Int64(viewmodel.vote_count)
        item.vote_average = viewmodel.vote_average
        
        
        do
        {
            try Context.save()
            completion(.success(()))
        }catch
        {
            completion(.failure(DatabaseError.FailedToloadData))
        }
    }
    
    func fetchAllmoviesDownloaded(completion: @escaping(Result<[TitleItems], Error>) -> Void)
    {
        guard let MyAppDelegate = UIApplication.shared.delegate as? AppDelegate else
        {return}
        
        let Context = MyAppDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItems> = TitleItems.fetchRequest()
        
        do
        {
            let mytitles = try Context.fetch(request)
            completion(.success(mytitles))
            
        }catch
        {
            completion(.failure(DatabaseError.FailedToloadData))
        }
        
        
    }
    
    
    func deleteItemFromStorage(viewmodel: TitleItems , completion: @escaping(Result<Void, Error>) -> Void)
    {
        guard let MyAppDelegate = UIApplication.shared.delegate as? AppDelegate else
        {return}
        
        let Context = MyAppDelegate.persistentContainer.viewContext
        
        Context.delete(viewmodel)
        do
        {
            try Context.save()
            
            completion(.success(()))
        }catch
        {
            completion(.failure(DatabaseError.FailedTodeleteData))
        }
        
        
    }
    
    func saveDataItemIntoStorage(viewModel: TitleItems, completion: @escaping(Result<Void, Error>) -> Void)
    {
        
        
        guard let MyAppDelegate = UIApplication.shared.delegate as? AppDelegate else
        {return}
        
        let Context = MyAppDelegate.persistentContainer.viewContext
        

        
    }
}
