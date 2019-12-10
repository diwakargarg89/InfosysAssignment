//
//  JsonParsingModel.swift
//  InfosysAssignment
//
//  Created by Diwakar Garg on 09/12/2019.
//  Copyright © 2019 Diwakar Garg. All rights reserved.
//

import Foundation

struct JsonParsingModel: Codable {
    let titleKey: String?
    let rowsKey: [Rows]?

    enum CodingKeys: String, CodingKey {

        case titleKey = "title"
        case rowsKey = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        titleKey = try values.decodeIfPresent(String.self, forKey: .titleKey)
        rowsKey = try values.decodeIfPresent([Rows].self, forKey: .rowsKey)
    }

}

struct Rows: Codable {
    let rowTitle: String?
    let description: String?
    let imageHref: String?

    enum CodingKeys: String, CodingKey {

        case rowTitle = "title"
        case description = "description"
        case imageHref = "imageHref"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rowTitle = try values.decodeIfPresent(String.self, forKey: .rowTitle)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
    }

}
