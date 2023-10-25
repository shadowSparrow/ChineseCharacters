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
    
    let charactersLink = "https://api.ctext.org/getcharacter?char="
    
    func fetchData(of character: Characters, with completion: @escaping(Character) -> Void) {
        let originalString = character.rawValue
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let escapedString = escapedString else { return }
        let characterLink = charactersLink + escapedString
        guard let url = URL(string: characterLink ?? "") else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription)
                return
            }
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                
                DispatchQueue.main.async {
                    completion(json)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
