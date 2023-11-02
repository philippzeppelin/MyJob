//
//  NetworkService.swift
//  MyJob
//
//  Created by Philipp Zeppelin on 30.10.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getJobs(page: Int, completion: @escaping (Result<JobsModel, ErrorResponce>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private var task: URLSessionDataTask?

    func getJobs(page: Int, completion: @escaping (Result<JobsModel, ErrorResponce>) -> Void) {
        let baseUrl = "http://185.174.137.159/jobs"

        guard let url = URL(string: baseUrl) else { return }

        var request = URLRequest(url: url)

        task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let decodedData = try decoder.decode(JobsModel.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.noData))
            }
        }
        task?.resume()
    }
}
