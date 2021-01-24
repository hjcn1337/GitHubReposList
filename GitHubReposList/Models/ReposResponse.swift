//
//  ReposResponse.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 20.01.2021.
//

import Foundation

struct ReposResponseElement: Codable {
    let id: Int
    let name: String
    let owner: Owner
    let reposResponseDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name, owner
        case reposResponseDescription = "description"
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
}

typealias ReposResponse = [ReposResponseElement]
