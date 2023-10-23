//
//  NetworkingManager.swift
//  ChineseCharacters
//
//  Created by mac on 21.10.2023.
//

import Foundation


class NetworkingManager {
    
    
    static let shared = NetworkingManager()

    private init() {}
    
    
    func fetchData(from url: String?, with completion: @escaping(Character) -> Void) {
        guard let url = URL(string: url ?? "") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error descruption")
                return}
            
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    completion(json)
                }
            } catch {
                print(error)
            }
        }.resume()
        
    }
}
