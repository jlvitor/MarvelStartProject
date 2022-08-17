//
//  HeroManager.swift
//  MarvelStartProject
//
//  Created by Jean Lucas Vitor on 13/05/22.
//

import Foundation
import CryptoKit

protocol HeroManagerDelegate {
//    func didUpdateHero(_ heroManager: HeroManager, hero: APICharacterData)
    func didFailWithError(error: Error)
}

struct HeroManager {
    
    let heroURL = "https://gateway.marvel.com:443/v1/public/characters"
    let privateKey = "0b7f1e4597ac18c335720ce036dfd55ef3f419e8"
    let publicKey = "5ad142540afaecc1a4bee3d1245e55fd"
    
    var delegate: HeroManagerDelegate?
    
    func fetchHero() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(privateKey)\(publicKey)")
        
        let urlString = "\(heroURL)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        performRequest(with: urlString)
    }
    
    // Create md5 hash
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
    func performRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //4/ Convert safeData into a String
                    if let hero = self.parseJSON(safeData) {
                        print(hero)
                    }
                }
            }
            //5. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ heroData: Data) -> APICharacterData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(APICharacterData.self, from: heroData)
            let id = decodedData.results[0].id
            let name = decodedData.results[0].name
            let description = decodedData.results[0].description
            let count = decodedData.count
//            let thumbnail = decodedData.results[0].thumbnail
            
            let hero = APICharacterData(count: count, results: [
                Character(
                    id: id,
                    name: name,
                    description: description
//                    thumbnail: thumbnail
                )
            ])
            return hero
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
