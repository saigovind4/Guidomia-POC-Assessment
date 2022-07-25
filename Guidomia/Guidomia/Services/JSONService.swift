//
//  JSONService.swift
//  Guidomia
//
//  Created by Govind Sonu on 25/07/22.
//

import Foundation
enum JSONError: Error {
    case badString
    case invalidData
    case decodingError
    case invalidFile
}

class JSONservice {
    
    func fetchCarDetails(completion: @escaping (Result<[CarDetail], JSONError>) -> Void)
    {
        guard let url = Bundle.main.url(forResource: "car_list", withExtension: "json") else {
            completion(.failure(.invalidFile))
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(.invalidData))
            return
        }
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([CarDetail].self, from: data)
            completion(.success(jsonData))
        } catch
        {
            completion(.failure(.decodingError))
        }

    }
}
