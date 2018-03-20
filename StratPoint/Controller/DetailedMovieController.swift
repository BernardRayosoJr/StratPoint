//
//  DetailedMovieController.swift
//  StratPoint
//
//  Created by Bernard Rayoso on 19/03/2018.
//  Copyright © 2018 bernardr. All rights reserved.
//

import UIKit

class DetailedMovieController: UIViewController {

    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgBackdrop: UIImageView!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var txtDetails: UITextView!
    

    var imgURLBackDrop: String?
    
    var detailMovie: Movies? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailMovie {
            loadViewIfNeeded()
            self.title = detail.title
            lblRating.text = "Rating: \(detail.rating )"
            lblYear.text = " Year released: \(detail.year)"
            lblTitle.text = detail.title
            txtDetails.text = detail.overview
            
            if let movieUrl = detailMovie?.slug
            {
                
                let imgBackdropURL =  URL(string:"https://aacayaco.github.io/movielist/images/" + movieUrl + "-backdrop.jpg")
                let imgCoverURL = URL(string: "https://aacayaco.github.io/movielist/images/" + movieUrl + "-cover.jpg")
                
                do{
                    let imgCoverData:NSData = try NSData(contentsOf: imgCoverURL!)
                    let imgBackdropData:NSData = try NSData(contentsOf: imgBackdropURL!)
                    
                    DispatchQueue.main.async {
                        let imageBackdrop = UIImage(data: imgBackdropData as Data)
                        let imageCover = UIImage(data: imgCoverData as Data)
                        
                        self.imgBackdrop.image = imageBackdrop
                        self.imgCover.image = imageCover
                    }
                    
                }catch let error {
                    print(error)
                    
                }
            }
            
        }
    }

}

extension DetailedMovieController: MovieSelectionDelegate {
    func movieSelected(_ newMovie: Movies) {
        detailMovie = newMovie
    }
    
  
    
}

