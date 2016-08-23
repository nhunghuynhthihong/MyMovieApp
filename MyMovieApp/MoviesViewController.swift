//
//  MoviesViewController.swift
//  MyMovieApp
//
//  Created by Nhung Huynh on 7/5/16.
//  Copyright © 2016 Nhung Huynh. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import AFNetworking

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [NSDictionary]()
    var baseUrl = "http://image.tmdb.org/t/p/w342"
    
    var activityIndicatorView: UIActivityIndicatorView!
    var rows: [String]! = nil
    
    let appDelegate = UIApplication.sharedApplication().delegate
    // Initialize a UIRefreshControl
    lazy var refreshControl = UIRefreshControl()
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    
    var indicator: NVActivityIndicatorView!
    var isFirstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets

//        let tableFooterView: UIView = UIView(frame: CGRectMake(0, 0, 320, 50))
//        let loadingView: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
//        
//        loadingView.startAnimating()
//        loadingView.center = tableFooterView.center
//        tableFooterView.addSubview(loadingView)
//        self.tableView.tableFooterView = tableFooterView
//        loadingView.stopAnimating()
        
        self.indicator = NVActivityIndicatorView(frame: CGRectMake((UIScreen.mainScreen().bounds.size.width - 80) / 2, UIScreen.mainScreen().bounds.size.height / 2 + 20, 80, 60), type: .BallPulseSync, color: UIColor(red: 55/255.0, green: 163/255.0, blue: 226/255.0, alpha: 1.0))
        self.view.addSubview(self.indicator)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loadDataForScreen()
        
    }
    func loadDataForScreen() {
        // network request
//        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
//        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
//        let request = NSURLRequest(
//            URL: url!,
//            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
//            timeoutInterval: 10)
//        
//        let session = NSURLSession(
//            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
//            delegate: nil,
//            delegateQueue: NSOperationQueue.mainQueue()
//        )
        var isIndicatorDisplayed = false
        if self.isFirstLoad {
            isIndicatorDisplayed = true
            self.isFirstLoad = false
            self.indicator.startAnimation()
        }
//        Networking
        
//        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
//            if error == nil {
//                if let data = dataOrNil {
//                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(data, options:[]) as? NSDictionary {
//                        self.movies = responseDictionary["results"] as![NSDictionary]
//                        print("Movies: \(self.movies)")
//                        self.loadingMoreView?.stopAnimating()
//                        if isIndicatorDisplayed {
//                            self.indicator.stopAnimation()
//                        }
//                        
//                        self.tableView.reloadData()
//                    }
//                }
//            } else {
//                let alertController = UIAlertController(title: "Error", message: "Put your error message here", preferredStyle: .Alert)
//                
//                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
//                    self.indicator.stopAnimation()
//                }
//                alertController.addAction(cancelAction)
//                self.presentViewController(alertController, animated: true, completion: nil)
//            }
//            
//        })
//        task.resume()

    }
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    func refreshControlAction(refreshControl: UIRefreshControl) {
        loadDataForScreen()
        refreshControl.endRefreshing()
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        cell.titleLabel.text = movies[indexPath.row]["title"] as! String
        
        cell.overviewLabel.text = movies[indexPath.row]["overview"] as! String

        
        let posterPath =  movies[indexPath.row]["poster_path"] as? String
        if let _posterpath = posterPath {
            let posterUrl = baseUrl + _posterpath
            let url = NSURL(string: posterUrl)
            cell.posterImage.setImageWithURL(url!)
        }
        if indexPath.row == movies.count-1 {
            isMoreDataLoading = true
        }
        return cell
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let nextVC = segue.destinationViewController as! DetailsViewController
        let indexPath = tableView.indexPathForSelectedRow
        let overview = movies[(indexPath?.row)!]["overview"] as! String
        let urlString = baseUrl + ( movies[indexPath!.row]["poster_path"] as! String )
        nextVC.overview = overview
        nextVC.posterUrl = urlString
        
        
    }
    
}
extension MoviesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print("scrollViewDidScroll")
        if(!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                loadDataForScreen()
            }
            
        }
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
//        if decelerate == true {
//            let cellVisible = tableView.indexPathsForVisibleRows
//            let queue = NSOperationQueue()
//            queue.cancelAllOperations()
//            let opration = NSOperation()
//            opration.start()
//            opration.cancel()
//        }
    }
}


class DownLoadImage: NSOperation {
    override func main() {
        
    }
}