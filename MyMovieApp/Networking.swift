//
//  Networking.swift
//  MyMovieApp
//
//  Created by Nhung Huynh on 7/11/16.
//  Copyright © 2016 Nhung Huynh. All rights reserved.
//

import Foundation

class Networking {
    // network request
    
    static var networking: Networking?
    
    let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    let session: NSURLSession?
    
    private init(){
        session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
        
        
       request.HTTPMethod = method
        session?.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
            if let data = data {
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                    completion(success: true, object: json)
                } else {
                    completion(success: false, object: json)
                }
            }
        })
    }
    private func post(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "POST", completion: completion)
    }
    private func put(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "PUT", completion: completion)
    }
    private func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }
    func loadMovies(success: (Movie)->(), failure: (NSError)->()){
        post(clientURLRequest("now_playing", params: nil)) { (success, object) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if success {
//                    completion(success: true, message: nil)
                } else {
                    var message = "there was an error"
                    if let object = object, let passedMessage = object["message"] as? String {
                        message = passedMessage
                    }
//                    completion(success: true, message: message)
                }
            })
        }
        
    }
    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://api.themoviedb.org/3/movie/" + path + "?api_key=\(apiKey)")!)
        
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = key.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                let escapedValue = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
                paramString += "\(escapedKey)=\(escapedValue)&"
            }
            
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        }
        return request
    }
}