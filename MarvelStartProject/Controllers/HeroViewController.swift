//
//  HeroViewController.swift
//  MarvelStartProject
//
//  Created by Jean Lucas Vitor on 12/05/22.
//

import UIKit

class HeroViewController: UIViewController {
    
    @IBOutlet weak var heroTableView: UITableView!
    
    var heroData: APICharacterData?
    var heroManager = HeroManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false

        heroTableView.dataSource = self
        heroTableView.delegate = self
        self.heroManager.delegate = self
    }
}

extension HeroViewController: HeroManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension HeroViewController: UITableViewDelegate {

}

extension HeroViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = heroTableView.dequeueReusableCell(withIdentifier: "heroCustomCell", for: indexPath) as? HeroTableViewCell
        DispatchQueue.main.async {
            cell?.setUpCell(data: (self.heroData?.results[indexPath.row])!)
        }
        return cell ?? UITableViewCell()
    }
        
}
