//
//  DetailsViewController.swift
//  MyMovieApp
//
//  Created by Nhung Huynh on 7/7/16.
//  Copyright © 2016 Nhung Huynh. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var posterUrl: String = ""
    var overview: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewLabel.text = overview
        let url = NSURL(string: posterUrl)
        //make sure your image in this url does exist, otherwise unwrap in a if let check
        if let data = NSData(contentsOfURL: url!) {
            posterImage.image = UIImage(data: data)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
