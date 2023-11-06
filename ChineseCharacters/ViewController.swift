//
//  ViewController.swift
//  ChineseCharacters
//
//  Created by mac on 13.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    var character: String?
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .white
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 120.0)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readingLabel: UILabel = {
        let label = UILabel()
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .white
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36.0)
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     private let characterView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
         view.layer.cornerRadius = 5
         view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let radicalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.backgroundColor = .blue
        label.textColor = .white
        return label
    }()
    
    private let strokesLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.backgroundColor = .blue
        label.textColor = .white
        return label
    }()
    
    private let characterDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        //stackView.backgroundColor = .cyan
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: TODO
    private let strokesString: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "strokes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let radicalString: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "radical"
        return label
    }()
    
    private let stringsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        //stackView.backgroundColor = .black
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.isHidden = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        setUIElements()
        print(character!)
        NetworkingManager.shared.fetchData(of: character ?? "No String") { character in
            self.characterLabel.text = character.char
            self.readingLabel.text = character.readings?.mandarinpinyin?.first
            self.radicalLabel.text = character.radical
            self.strokesLabel.text = character.totalstrokes
            self.stringsStackView.isHidden = false
        }
    }
    
    //MARK: CreateUI
    func setUIElements() {
        characterView.addSubview(characterLabel)
        characterView.addSubview(readingLabel)
        stringsStackView.addArrangedSubview(radicalString)
        stringsStackView.addArrangedSubview(strokesString)
        characterView.addSubview(stringsStackView)
        characterDataStackView.addArrangedSubview(radicalLabel)
        characterDataStackView.addArrangedSubview(strokesLabel)
        characterView.addSubview(characterDataStackView)
        self.view.addSubview(characterView)
        
        //setConstraints
        let screenWindth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let viewWindth = screenWindth/1.5
        let viewHeight = screenHeight/2.5
        
        NSLayoutConstraint.activate([
            
            characterView.widthAnchor.constraint(equalToConstant: viewWindth),
            characterView.heightAnchor.constraint(equalToConstant: viewHeight),
            characterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            characterLabel.widthAnchor.constraint(equalToConstant: 200),
            characterLabel.heightAnchor.constraint(equalToConstant: 150),
            characterLabel.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            characterLabel.topAnchor.constraint(equalTo: characterView.topAnchor, constant: 10),
            
            readingLabel.widthAnchor.constraint(equalToConstant: 200),
            readingLabel.heightAnchor.constraint(equalToConstant: 38),
            readingLabel.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            readingLabel.topAnchor.constraint(equalTo: characterLabel.bottomAnchor),
            
            stringsStackView.widthAnchor.constraint(equalToConstant: viewWindth),
            stringsStackView.heightAnchor.constraint(equalToConstant: 40),
            stringsStackView.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            stringsStackView.bottomAnchor.constraint(equalTo: characterView.bottomAnchor),
            
            characterDataStackView.widthAnchor.constraint(equalToConstant: viewWindth),
            characterDataStackView.heightAnchor.constraint(equalToConstant: 80),
            characterDataStackView.centerXAnchor.constraint(equalTo: characterView.centerXAnchor),
            characterDataStackView.bottomAnchor.constraint(equalTo: stringsStackView.topAnchor)
        
             ])
        
    }
    
    //MARK: Networking
    /*
    func fetchCharacter(character: Characters) {
        //let string = getCharacterLink(character: character)
        NetworkingManager.shared.fetchData(from: string) { character in
           print(character)
            self.characterLabel.text = character.char
            self.readingLabel.text = character.readings?.mandarinpinyin?.first
            self.radicalLabel.text = character.radical
            self.strokesLabel.text = character.totalstrokes
        }
    }
    
    */
    /*
    let link = "https://api.ctext.org/getcharacter?char="
    func getCharacterLink(character: Characters) -> String {
        let originalString = character.rawValue
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let escapedString = escapedString else {
            return "EscapinkStringError"}
        let characterLink = link + escapedString
        return characterLink
    }
     */
}


