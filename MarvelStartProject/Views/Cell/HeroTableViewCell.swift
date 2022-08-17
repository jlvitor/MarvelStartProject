//
//  HeroTableViewCell.swift
//  MarvelStartProject
//
//  Created by Jean Lucas Vitor on 12/05/22.
//

import UIKit

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    let heroWithoutImage = UIImage(systemName: "person.fill.questionmark")
    
    public func setUpCell(data: Character) {
        DispatchQueue.main.async {
            //        self.heroImageView.image = UIImage(named: data.results[0].thumbnail)
            self.heroNameLabel.text = data.name.uppercased()
            
            self.heroNameLabel.font = UIFont(name: "Marvel", size: 25)
        }
    }
}
