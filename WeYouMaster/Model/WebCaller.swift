//
//  WebCaller.swift
//  WeYouMaster
//
//  Created by alireza on 8/11/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
public class WebCaller {
    
    static func getCollection(completionHandler: @escaping (CollectionList?, Error?) -> Void){
        let endpoint = "https://www.weyoumaster.com/api/collections/"
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = ""
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                let  collectionL  = try JSONDecoder().decode(CollectionList.self,from: responseData)
                completionHandler(collectionL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
    }
    static func getFeeds(_ per_page: Int ,_ current_page: Int, completionHandler: @escaping (ContentList?, Error?) -> Void) {
        let endpoint = "https://www.weyoumaster.com/api/feed"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
      /*  let postString = "itemPerPage=" + String(per_page) + "&currentPage=" + String(current_page)
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)*/
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                print(responseData)
                let  contentL  = try JSONDecoder().decode(ContentList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getLogin(_ email: String ,_ pass: String, completionHandler: @escaping (LoginResponse?, Error?) -> Void) {
        // set up URLRequest with URL
        let endpoint = "https://www.weyoumaster.com/api/login/"
        guard let url = URL(string: endpoint)
            else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "emailaddress=" + email + "&password=" + pass
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)

        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                if let todoJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any],
                    let todo = LoginResponse(json: todoJSON) {
                
                    // created a TODO object
                    completionHandler(todo, nil)
                } else {
                    // couldn't create a todo object from the JSON
                    let error = BackendError.objectSerialization(reason: "Couldn't create a todo object from the JSON")
                    completionHandler(nil, error)
                }
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
    }
    
    static func saveFeed(owner: String , location : String , publicState : Int, align : Int , contentType : Int , collectionId : Int, title : String , description : String , link : String , apparatLink : String,
                         youtubeLink : String,insertTimeStamp : Int64 , completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        
        
        // set up URLRequest with URL
        let endpoint = "https://www.weyoumaster.com/api/add_contribution"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        var postString = "";
        postString.append("owner=")
        postString.append(owner)
        postString.append("&location=")
        postString.append(location)
        postString.append("&publicState=")
        postString.append(String(publicState))
        let b = "&title="
        postString.append(b)
        postString.append(title)
        postString.append("&align=")
        postString.append(String(align))
        postString.append("&contentType=")
        let a = String(contentType)
        postString.append(a)
        postString.append("&description=")
        postString.append(description)
        postString.append("&link=")
        postString.append(link)
        postString.append("&apparatLink=")
        postString.append(apparatLink)
        postString.append("&youtubeLink=")
        postString.append(youtubeLink)
        postString.append("&insertTimeStamp=")
        postString.append(String(insertTimeStamp))
        

        
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        // Make request
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            // handle response to request
            // check for error
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            // make sure we got data in the response
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                print(responseData)
                let  resp  = try JSONDecoder().decode(NormalResponse.self,from: responseData)
                completionHandler(resp,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
        
    }
    
    
    
}
