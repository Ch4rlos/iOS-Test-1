//
//  Structs.swift
//  Kinedu iOS Test
//
//  Created by Developer on 10/22/19.
//  Copyright © 2019 Appsodi. All rights reserved.
//

import Foundation

struct NPS: Codable {
    var id : Int?
    var nps : Int?
    var days_since_signup : Int?
    var user_plan : String?
    var activity_views : Int?
    var build : Build?
}

struct Build: Codable {
    var version : String?
    var release_date : String?
}

struct CollectionMenu {
    var babyImage : String?
    var number : Int!
}
