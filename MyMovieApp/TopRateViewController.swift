//
//  TopRateViewController.swift
//  MyMovieApp
//
//  Created by Nhung Huynh on 7/11/16.
//  Copyright © 2016 Nhung Huynh. All rights reserved.
//

import UIKit

class TopRateViewController: UIViewController {

    enum ViewMode {
        case List
        case Grid
    }
    
    var currentViewMode: ViewMode = .List {
        didSet {
            switch currentViewMode {
            case .Grid:
                currentViewMode = .Grid
                
            case .List:
                currentViewMode = .List
                
            }
            collectionView.reloadData()
        }
        
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func segmentControl(sender: UISegmentedControl) {
                currentViewMode = .List
        
        switch  sender.selectedSegmentIndex {
        case 1:
            currentViewMode = .Grid
        default:
            currentViewMode = .List
        }
    }
    
    var baseUrl = "http://image.tmdb.org/t/p/w342"

    var movies = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.estimatedItemSize = CGSize(width: collectionView.bounds.width - (20), height: 150)
        loadDataForScreen()
    }
    
    func loadDataForScreen() {
        // network request
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
//        var isIndicatorDisplayed = false
//        if self.isFirstLoad {
//            isIndicatorDisplayed = true
//            self.isFirstLoad = false
//            self.indicator.startAnimation()
//        }
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
            if error == nil {
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
                        self.movies = responseDictionary["results"] as![NSDictionary]
                        print("Movies: \(self.movies)")
//                        self.loadingMoreView?.stopAnimating()
//                        if isIndicatorDisplayed {
//                            self.indicator.stopAnimation()
//                        }
                        
                        self.collectionView.reloadData()
                    }
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Put your error message here", preferredStyle: .Alert)
                
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
//                    self.indicator.stopAnimation()
                }
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        })
        task.resume()
        
    }
}
extension TopRateViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TopRateCell
        cell.titleLabel.text = movies[indexPath.row]["title"]! as? String
        
        cell.overviewLabel.text = movies[indexPath.row]["overview"] as? String
        let posterPath =  movies[indexPath.row]["poster_path"] as? String
        if let _posterpath = posterPath {
            let posterUrl = baseUrl + _posterpath
            let url = NSURL(string: posterUrl)
            cell.posterImage.setImageWithURL(url!)
        }
        
        return cell
    }
}
extension TopRateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch currentViewMode {
        case .List:
            return CGSize(width: collectionView.bounds.width - 10, height: 200.0)
        case .Grid:
            return CGSize(width: collectionView.bounds.width/2 - 10, height: 200.0)
        }
        
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
//        
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.estimatedItemSize = CGSize(width: collectionView.bounds.width - (100), height: 150)
//        
//        return 40
//    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        switch currentViewMode {
        case .List:
            return UIEdgeInsetsZero
        case .Grid:
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        }
    }
}

