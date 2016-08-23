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
    
    @IBOutlet weak var contentView: UIView!
    var posterUrl: String = ""
    var overview: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
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
