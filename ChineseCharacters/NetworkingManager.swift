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
    
    func fetchData(of character: String, with completion: @escaping(Character) -> Void) {
        let originalString = character
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let escapedString = escapedString else { return }
        let characterLink = charactersLink + escapedString
        guard let url = URL(string: characterLink ) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "NoError description")
                return
            }
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                
                //DispatchQueue.global().async {
                    DispatchQueue.main.async {
                        completion(json)
                    }
                //}
              
            }
            catch {
                print(error)
            }
        }.resume()
    }
}

/*
 DispatchQueue.global().async {
     guard let url = URL(string: course.imageUrl ?? "No image") else {return}
     guard let imageData = try? Data(contentsOf: url) else {return}
     let image = UIImage(data: imageData)
         
         DispatchQueue.main.async {
         self.courseImage.image = image
         }
 }
}
 */
