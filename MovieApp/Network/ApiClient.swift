//
//  ApiClient.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import Foundation

typealias CompletionSuccess<T : Codable> = (T)->Void
typealias CompletionError = (Error)->Void

struct APIClient <Entity : Codable>{
    
    static func performRequest(request : RequestModel ,  completion :@escaping (Result<Entity , Error>)->Void) {
        let decoder = JSONDecoder()
        
        let urlSession = URLSession.shared.dataTask(with: request.buildRequest()) { data , response , error in
            DispatchQueue.main.async {
                if let data = data {
                    
                    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                       let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        print(String(decoding: jsonData, as: UTF8.self))
                    } else {
                        print("json data malformed")
                    }

                    
                    do{
                        let model = try decoder.decode(Entity.self, from: data)
                        completion(.success(model))
                        
                    }catch {
                        completion(.failure(error))
                    }
                    
                    
                } else if let error = error {
                    completion(.failure(error))
                }
            }
            
        }
        urlSession.resume()
        
        
    }
    
}
