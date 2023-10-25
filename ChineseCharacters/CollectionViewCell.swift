//
//  CollectionViewCell.swift
//  ChineseCharacters
//
//  Created by mac on 25.10.2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
     lazy var characterLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.backgroundColor = .blue
        
        setUIElemets()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUIElemets() {
        self.addSubview(characterLabel)
        //constraints
        characterLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        characterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
}
