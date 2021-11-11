//
//  NetworkingService.swift
//  SBTask
//
//  Created by Daniel Rybak on 11/09/2021.
//  Copyright © 2021 The Beans Group. All rights reserved.
//

import Foundation


protocol NetworkServiceProtocol {
  func urlStringToData(urlString: String, completion: @escaping ((Data?)->()))
  func performNetworkCall<T: Codable>(urlString: String, objectType: T.Type, completion: @escaping ((T?)->()))
}

class NetworkService: NetworkServiceProtocol {
  func urlStringToData(urlString: String, completion: @escaping ((Data?)->())) {
    
    guard let url = URL(string: urlString) else {
      print("Invalid URL: \(urlString)")
      return completion(nil)
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error.localizedDescription)
        return completion(nil)
      }
      
      if let response = response as? HTTPURLResponse {
        if response.statusCode != 200 {
          DispatchQueue.main.async {
            print("Error: Server responded with code \(response.statusCode)")
            return completion(nil)
          }
        }
      }
      
      if let data = data {
        DispatchQueue.main.async {
          return completion(data)
        }
      }
      
      return completion(nil)
      
    }.resume()
  }
  
  func performNetworkCall<T: Codable>(urlString: String, objectType: T.Type, completion: @escaping ((T?)->())) {
    
    guard let url = URL(string: urlString) else {
      print("Invalid URL: \(urlString)")
      return completion(nil)
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        print(error.localizedDescription)
        completion(nil)
      }
      
      if let response = response as? HTTPURLResponse {
        if response.statusCode != 200 {
          DispatchQueue.main.async {
            print("Error: Server responded with code \(response.statusCode)")
            completion(nil)
          }
        }
      }
      
      if let data = data {
        DispatchQueue.main.async {
          do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            print("Network Service Found Data")
            return completion(decodedResponse)
            
          } catch let DecodingError.dataCorrupted(context) {
            print(context.codingPath)
            
          } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
          } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
          } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            
          } catch {
            print("error: ", error)
          }
          
        }
      }
    }.resume()
  }
}
