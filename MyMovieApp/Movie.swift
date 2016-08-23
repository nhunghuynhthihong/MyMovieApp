//
//  Movie.swift
//  MyMovieApp
//
//  Created by Nhung Huynh on 8/2/16.
//  Copyright © 2016 Nhung Huynh. All rights reserved.
//

import Foundation

class Movie {
    var title: String?
    var overview: String?
    var poster: NSURL?
    
    var dictionary: NSDictionary?
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        title = dictionary["title"] as? String
        overview = dictionary["overview"] as? String
        
        let poster = dictionary["poster"] as? String
        if let poster = poster {
            self.poster = NSURL(string: poster)
        }
    }
    
    init(title: String?, overview: String?, poster: String?) {
        self.title = title
        self.overview = overview
        self.poster = NSURL(fileURLWithPath: poster!)
    }
}