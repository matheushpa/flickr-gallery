//
//  FlickrService.swift
//  Flickr Gallery
//
//  Created by Matheus Holanda Pinheiro de Albuquerque on 14/09/20.
//  Copyright © 2020 Matheus Holanda. All rights reserved.
//

import Foundation

class FlickrAPI {
    
    static let shared = FlickrAPI()
    private var task: URLSessionDataTask?
    private let session: URLSession = {
        return URLSession(configuration: URLSessionConfiguration.default)
    }()
    
    func fetch<K:Decodable>(model: K.Type, params: [String: Any], completion: @escaping (K?, Error?) -> Void) {
        guard let url = getURLWithParameters(parameters: params) else {
            completion(nil, nil)
            return
        }
        let request = URLRequest(url: url)
        task = session.dataTask(with: request) { (rawData, response, error) in
            guard let data = rawData, error == nil else {
                print("request/data error: ", error ?? "<empty error log>", separator: "\n")
                completion(nil, error)
                return
            }
            do {
                let response: K? = try JSONDecoder.default.decode(model, from: data)
                completion(response, nil)
            } catch let jsonError {
                print("decoding error: ", jsonError)
                completion(nil, jsonError)
            }
        }
        task?.resume()
    }
    
    private func getURLWithParameters(parameters: [String: Any]) -> URL? {
        var urlRequest = URLComponents(string: APIConstants.baseURL)
        if !parameters.isEmpty {
            urlRequest?.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlRequest?.queryItems?.append(queryItem)
            }
        }
        return urlRequest?.url
    }
}
