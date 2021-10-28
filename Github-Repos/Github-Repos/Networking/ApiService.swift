//
//  ApiService.swift
//  Github-Repos
//
//  Created by Anshul Singh Koshyari on 27/10/21.
//

import Foundation

class ApiService {
    
    var dataTask: URLSessionDataTask?
    
    func parseJSON(completion: @escaping(Result<Repo, Error>) -> Void) {
        guard let url = URL(string: Constants.API) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
            }
    
            //Handle Empty Response
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            //Handle Empty Data
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            //Parse the Data
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Repo.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    
}
