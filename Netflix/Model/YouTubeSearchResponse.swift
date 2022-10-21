//
//  YouTubeSearchResponse.swift
//  Netflix
//
//  Created by Erick El nino on 2022/10/17.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation



struct YouTubeSearchResponse:Codable
{
    let items:[Videos]
}


struct Videos:Codable
{
    let id:IdVideos
}

struct IdVideos:Codable
{
    let kind: String
    let videoId: String
}
