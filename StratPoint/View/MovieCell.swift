//
//  MovieCell.swift
//  StratPoint
//
//  Created by Bernard Rayoso on 19/03/2018.
//  Copyright © 2018 bernardr. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    
    var baseImageURL: String?
    var imageURL: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    

    func setMovies (movies: Movies)
    {
        
        self.baseImageURL = "https://aacayaco.github.io/movielist/images/" + movies.slug + "-backdrop.jpg"
        self.imageURL = URL(string: baseImageURL!)
 
        //    https://aacayaco.github.io/movielist/images/the-shawshank-redemption-1994-cover.jpg
        //    https://aacayaco.github.io/movielist/images/the-shawshank-redemption-1994-backdrop.jpg
        
        titleLbl.text = movies.title
        yearLbl.text = String(movies.year)
        imageBackground.downloadedFrom(url: imageURL!)
        
        
        
    }
    
}
