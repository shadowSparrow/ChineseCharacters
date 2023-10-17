//
//  ViewController.swift
//  ChineseCharacters
//
//  Created by mac on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 120.0)
        //label.font = UIFont(name: "FZKai-Z03S", size: 120)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readingLabel: UILabel = {
        let label = UILabel()
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36.0)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private let characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
         view.layer.cornerRadius = 5
         view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: TODO
    private let strokesString: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .white
        label.text = "strokes"
        
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
    
    func setUIElements() {
        self.view.addSubview(characterView)
        
        
        
        characterView.addSubview(characterLabel)
        characterView.addSubview(readingLabel)
        
        //setConstraints
        
        let screenWindth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        NSLayoutConstraint.activate([
            characterView.widthAnchor.constraint(equalToConstant:  screenWindth/1.5),
            characterView.heightAnchor.constraint(equalToConstant: screenHeight/2.5),
            characterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            characterLabel.widthAnchor.constraint(equalToConstant: 200),
            characterLabel.heightAnchor.constraint(equalToConstant: 150),
                                                   
            characterLabel.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            characterLabel.topAnchor.constraint(equalTo: characterView.topAnchor),
            
            readingLabel.widthAnchor.constraint(equalToConstant: 200),
            readingLabel.heightAnchor.constraint(equalToConstant: 50),
            readingLabel.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            readingLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor),
            
            
        ])
        
        
        
        //self.view.addSubview(characterLabel)
        //self.view.addSubview(readingLabel)
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


