//
//  ViewController.swift
//  ChineseCharacters
//
//  Created by mac on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var characterLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 190, height: 150))
        label.center.x = self.view.center.x
        label.center.y = self.view.center.y
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        label.textColor = .white
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.text = "Character"
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var readingLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 190, height: 50))
        label.center.x = self.view.center.x
        label.center.y = self.view.center.y + 104
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.text = "PingYing"
        //label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter(character: Characters.脑)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.backgroundColor = .white
        setUIElements()
    }
    
    //MARK: CreateUI
    
    func setUIElements(){
        self.view.addSubview(characterLabel)
        self.view.addSubview(readingLabel)
    }
    
    //MARK: Networking
    func fetchCharacter(character: Characters) {
        let string = getCharacterLink(character: character)
        
        guard let url = URL(string: string) else {
            print("String problem")
            return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(data)
            
            do {
                let json = try JSONDecoder().decode(Character.self, from: data)
                print(json)
                
                DispatchQueue.main.async {
                    self.characterLabel.text = json.char
                    self.readingLabel.text = json.readings?.mandarinpinyin?.first
                }
                
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
        
    }
    
    
    let link = "https://api.ctext.org/getcharacter?char="
    func getCharacterLink(character: Characters) -> String {
        let originalString = character.rawValue
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let escapedString = escapedString else {
            return "EscapinkStringError"}
        let characterLink = link + escapedString
        return characterLink
    }
    
    
}


