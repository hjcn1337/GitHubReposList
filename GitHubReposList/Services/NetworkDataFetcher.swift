//
//  NetworkDataFetcher.swift
//  GitHubReposList
//
//  Created by Ростислав Ермаченков on 20.01.2021.
//

import Foundation

protocol DataFetcher {
    func getRepos(nextBatchFrom: String, response: @escaping (ReposResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getRepos(nextBatchFrom: String, response: @escaping (ReposResponse?) -> Void) {
        
        let params = ["type": "public", "page": nextBatchFrom]
        networking.request(path: API.repos, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: ReposResponse.self, from: data)
            print(data)
            print(decoded)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
