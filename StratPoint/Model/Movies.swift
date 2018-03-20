//
//  Movie.swift
//  StratPoint
//
//  Created by Bernard Rayoso on 19/03/2018.
//  Copyright © 2018 bernardr. All rights reserved.
//


import UIKit


class Movies {
    let title : String
    let year : Int
    let slug: String
    let overview: String
    let rating : Int

    init(json : [String : Any]) {
        title = json["title"] as? String ?? ""
        year = json["year"] as? Int ?? 0
        slug = json["slug"] as? String ?? ""
        overview = json["overview"] as? String ?? ""
        rating = json["rating"] as? Int ?? 0
        
      
    }
 }
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}




