//
//  Movies.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/09.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation



struct Title:Codable
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
  
}

struct TrendingTitleResponse:Codable
{
    let results: [Title]
}



