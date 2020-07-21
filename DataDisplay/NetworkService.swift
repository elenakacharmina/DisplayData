//
//  NetworkService.swift
//  DataDisplay
//
//  Created by Elena Kacharmina on 20.07.2020.
//  Copyright © 2020 Elena Kacharmina. All rights reserved.
//

import Foundation


protocol NetWorkServiceProtocol {
    func getData(completion: @escaping (Result<DataForTable, Error>) -> Void)
}

class NetworkService: NetWorkServiceProtocol {
    func getData(completion: @escaping (Result<DataForTable, Error>) -> Void) {
        if let url = URL(string: "https://pryaniky.com/static/json/sample.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let jsonData = try? JSONDecoder().decode(DataForTable.self, from: data ?? Data()) {
                        completion(.success(jsonData))
                    }
                    else {
                        completion(.failure(NSError(domain:"", code: 400, userInfo:[ NSLocalizedDescriptionKey: "Can't parse the data"]) as Error))
                    }
                }
            }.resume()
        }
    }
}
