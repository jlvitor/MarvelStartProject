//
//  ViewController.swift
//  MarvelStartProject
//
//  Created by Jean Lucas Vitor on 12/05/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var continueTextLabel: UILabel!
    
    let welcomeMessage: String = "Welcome to the Marvel world"
    let continueMessage: String = "Tap on the screen to continue"
    
    var heroManager = HeroManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setLabel()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(nextScreen(_:))
        )
        self.view.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HeroViewController {
            if let hero = sender as? APICharacterData {
                vc.heroData = hero
            }
        }
    }

    @objc func nextScreen(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "nextScreen", sender: self)
        heroManager.fetchHero()
    }
    
    private func setLabel() {
        logoImageView.image = UIImage(named: "marvel")
        
        welcomeTextLabel.font = UIFont(name: "Marvel", size: 70)
        welcomeTextLabel.text = welcomeMessage.uppercased()
        
        continueTextLabel.font = UIFont(name: "marvel", size: 25)
        continueTextLabel.text = continueMessage.uppercased()
    }

}

