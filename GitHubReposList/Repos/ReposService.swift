//
//  ReposWorker.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 20.01.2021.
//

import Foundation

class ReposService {
    var networking: Networking
    var fetcher: DataFetcher
    
    private var reposResponse: ReposResponse?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }

    
    func getRepos(completion: @escaping (ReposResponse) -> Void) {
        fetcher.getRepos(nextBatchFrom: nil) { [ weak self] (repos) in
            self?.reposResponse = repos
            guard let reposResponse = self?.reposResponse else { return }
            completion(reposResponse)
        }
    }
}
