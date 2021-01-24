//
//  ReposModels.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 24.01.2021.
//

import Foundation

enum Repos {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getRepos
        case getNextBatch
      }
    }
    struct Response {
      enum ResponseType {
        case presentRepos
        case presentFooterLoader
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayRepos(reposViewModel: ReposViewModel)
        case displayFooterLoader
      }
    }
  }
}

struct ReposViewModel {
    struct Cell: ReposCellViewModel {
        let id: Int
        let name: String
        let ownerLogin: String
        let description: String?
    }
 
    let cells: [Cell]
}

