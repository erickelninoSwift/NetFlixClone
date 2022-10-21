//
//  Tv.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/10.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation

struct TrendingTvs:Codable
{
    let results: [tv]
}

struct tv:Codable
{
    
     let id: Int
     let media_type:String?
     let original_name:String?
     let original_title:String?
     let title:String?
     let poster_path: String?
     let release_date:String?
     let overview:String?
     let vote_count: Int
     let vote_average: Double
     let popularity:Double
    
     
}
