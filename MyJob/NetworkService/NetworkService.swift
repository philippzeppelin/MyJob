//
//  NetworkService.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchJobs(from url: URL, completion: @escaping (Result<[JobsModelApi], ErrorResponce>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private var task: URLSessionDataTask?
    
    func fetchJobs(from url: URL, completion: @escaping (Result<[JobsModelApi], ErrorResponce>) -> Void) {
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(.apiError))
                return
            }

            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let jobsModelApi = try decoder.decode([JobsModelApi].self, from: data)
                completion(.success(jobsModelApi))
            } catch {
                completion(.failure(.noData))
            }
        }
        task?.resume()
    }
}
