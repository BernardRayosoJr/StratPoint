//
//  HomeVC.swift
//  StratPoint
//
//  Created by Bernard Rayoso on 20/03/2018.
//  Copyright © 2018 bernardr. All rights reserved.
//

import UIKit


protocol MovieSelectionDelegate: class {
    func movieSelected(_ newMovie: Movies)
}

class HomeVC: UITableViewController {


    @IBOutlet var homeTableView: UITableView!
    // MARK: - Initializers
    
    var movieList = [Movies]();
    var imgCoverUrl: URL?
    var detailViewController: DetailedMovieController? = nil
    
    weak var delegate: MovieSelectionDelegate?
    
    // URL TO FETCH
    let URL_MOVIES = "https://aacayaco.github.io/movielist/list_movies_page1.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        // Register custom MovieCell.xib
        
        homeTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "customMovieCell")
        
        // Configure Table
        configureTableView()
    
      // Fetch JSON Data
        getJsonObject{
            if let split = self.splitViewController {
                let controllers = split.viewControllers
                self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailedMovieController
                self.detailViewController?.detailMovie = self.movieList[0]
                
            }
            else {
                
                self.homeTableView.reloadData()
                
            }
        }

    }

    
    
    // MARK: - Network Fetch URL

    
    func getJsonObject(completed: @escaping () -> ()){
        
        guard let url = URL(string: URL_MOVIES) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
             if error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
                        else {
                            return
                    }
                    
                    let dataJSON = json["data"] as? [String: Any]
                    if let movieDict = dataJSON!["movies"] as? [[String:Any]] {
                        for movie in movieDict {
                            self.movieList.append(Movies(json: movie))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }
                catch let error {
                    print("Error serializing json:", error)
                    
                }}
            
            }.resume()
    }
    
    
    // MARK: - Table view data source

    
    func configureTableView() {
        homeTableView.rowHeight =  UITableViewAutomaticDimension
        homeTableView.estimatedRowHeight = 204
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieList.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMovieCell", for: indexPath) as! MovieCell
        // Configure the cell...
        cell.setMovies(movies: movieList[indexPath.row])

        return cell
    }


    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedMovie = movieList[indexPath.row]
        delegate?.movieSelected(selectedMovie)
       
        if let detailViewController = delegate as? DetailedMovieController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }


}
