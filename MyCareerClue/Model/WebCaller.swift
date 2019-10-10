//
//  WebCaller.swift
//  WeYouMaster
//
//  Created by alireza on 8/11/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class WebCaller {
    
    static func getCollection(_ items_per_page : Int ,_ startPage :Int ,
                              owner : String  , userId : String ,state : String ,
                              completionHandler: @escaping (CollectionList?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/collections/"
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "items_per_page=" + String(items_per_page) + "&startPage=" + String(startPage) +
            "&owner=" + owner  + "&userId=" + userId
        + "&randomStatus=" + state
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
    
    static func getProfileInfo(_ owner : String  ,
                              completionHandler: @escaping (InfoObject?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/userInfo//"
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&userInfo=" + owner
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
                
                let  info  = try JSONDecoder().decode(InfoObject.self,from: responseData)
                completionHandler(info,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
    }
    static func getTips(_ owner : String  ,
                               completionHandler: @escaping (MyTipList?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/show_my_tip/"
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner_id=" + owner
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
                
                let  info  = try JSONDecoder().decode(MyTipList.self,from: responseData)
                completionHandler(info,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
    }
    static func cancelTips(_ owner : String  ,_ tipId : String,
                        completionHandler: @escaping (String?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/cancel_tip/"
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner_id=" + owner + "&tip_id= " + tipId
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
                print(responseData)
                
                let  info  = "suscess"
                completionHandler(info,nil)
                
            
        })
        task.resume()
    }
    static func acceptTips(_ owner : String  ,_ tipId : String,
                           completionHandler: @escaping (String?, Error?) -> Void){
        let endpoint = "https://weyoumaster.com/api/cancel_tip/"
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner_id=" + owner + "&tip_id= " + tipId
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
            guard data != nil else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            
            
            let  info  = "suscess"
            completionHandler(info,nil)
            
            
        })
        task.resume()
    }
    
    static func getChapters(_ items_per_page: Int ,_ startPage: Int,_ randomStatus : String ,_ owner :String ,_ collectionId :String, completionHandler: @escaping (ChapterList?, Error?) -> Void) {
        
        let endpoint = "https://mycareerclue.com/api/chapters/"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner +  "&collectionId=" + collectionId + "&items_per_page=" + String(items_per_page) + "&startPage=" + String(startPage) + "&randomStatus=" + randomStatus
        
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(ChapterList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getCollectionOther(_ items_per_page : Int ,_ startPage :Int ,
                              owner : String  , userId : String ,
                              completionHandler: @escaping (CollectionOtherList?, Error?) -> Void){
        
        if(owner==userId){
            let endpoint = "https://mycareerclue.com/api/my_collections/"
            
            guard let url = URL(string: endpoint)
                else {
                    print("Error: cannot create URL")
                    let error = BackendError.urlError(reason: "Could not construct URL")
                    completionHandler(nil, error)
                    return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            let postString = "owner=" + owner
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
                    
                    let  collectionL  = try JSONDecoder().decode(CollectionOtherList.self,from:responseData)
                    completionHandler(collectionL,nil)
                    
                } catch {
                    // error trying to convert the data to JSON using JSONSerialization.jsonObject
                    completionHandler(nil, error)
                    return
                }
            })
            task.resume()
        }else{
            let endpoint = "https://mycareerclue.com/api/my_collections"
            
            guard let url = URL(string: endpoint)
                else {
                    print("Error: cannot create URL")
                    let error = BackendError.urlError(reason: "Could not construct URL")
                    completionHandler(nil, error)
                    return
            }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            let postString = "items_per_page=" + String(items_per_page) + "&startPage=" + String(startPage) +
                "&userId=" + userId + "&owner=" + userId
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
                    
                    let  collectionL  = try JSONDecoder().decode(CollectionOtherList.self,from:responseData)
                    completionHandler(collectionL,nil)
                    
                } catch {
                    // error trying to convert the data to JSON using JSONSerialization.jsonObject
                    completionHandler(nil, error)
                    return
                }
            })
            task.resume()
        }
     
    }
    
    static func block(_ profileId: String ,_ viewer_id: String, completionHandler: @escaping (BlockResp?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/block"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "profileId=" + String(profileId) +
            "&viewer_id=" + viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        
        
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
                let  contentL  = try JSONDecoder().decode(BlockResp.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func blockList(_ viewer_id: String, completionHandler: @escaping (BlockList?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/showmyblockedusers"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "viewer_id=" + String(viewer_id) +
            "&itemPerPage=100"
        + "&currentPage=1"
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        
        
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
                let  contentL  = try JSONDecoder().decode(BlockList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func reportList(_ viewer_id: String, completionHandler: @escaping (ReportList?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/showmyreportedclues"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "viewer_id=" + String(viewer_id) +
            "&itemPerPage=100"
            + "&currentPage=1"
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        
        
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
                let  contentL  = try JSONDecoder().decode(ReportList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func unReport(_ clueId: String ,_ viewer_id: String, completionHandler: @escaping (UndoObject?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/undoreport"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "clueId=" + String(clueId) +
            "&viewer_id=" + viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        
        
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
                let  contentL  = try JSONDecoder().decode(UndoObject.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func unblock(_ profileId: String ,_ viewer_id: String, completionHandler: @escaping (UnBlockObject?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/unblock"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "profileId=" + String(profileId) +
            "&viewer_id=" + viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        
        
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
                let  contentL  = try JSONDecoder().decode(UnBlockObject.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func report(_ clueId: String ,_ viewer_id: String, completionHandler: @escaping (ReportResp?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/report"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "clueId=" + String(clueId) +
            "&viewer_id=" + viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        
        
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
                let  contentL  = try JSONDecoder().decode(ReportResp.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func getFeeds(_ per_page: Int ,_ current_page: Int,_ viewer_id :String , completionHandler: @escaping (ContentList?, Error?) -> Void) {
        
        let userDefaults = UserDefaults.standard
        let key = userDefaults.value(forKey: "user_key") as! String
        let endpoint = "https://mycareerclue.com/api/feed"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "itemPerPage=" + String(per_page) + "&currentPage=" + String(current_page) +
            "&viewer_id=" + viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")

        
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
    static func getLikeList(viewer_id :String , completionHandler: @escaping (ContentList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/likesList"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "viewer_id=" + viewer_id + "&profile_id=" +  viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
    static func getFollowerList(viewer_id :String , completionHandler: @escaping (FollowingList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/followingList"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "viewer_id=" + viewer_id + "&profile_id=" +  viewer_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(FollowingList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    
    static func getUserFeed(_ per_page: Int ,_ current_page: Int,_ owner :String ,_ userId :String, completionHandler: @escaping (OtherContentList?, Error?) -> Void) {
        
        let endpoint = "https://mycareerclue.com/api/dashboard_contributions"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner +  "&userId=" + userId
       
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(OtherContentList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func getFeedsOfCollection(_ collectionId :String , completionHandler: @escaping (OtherContentListTwo?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/contributions_of_a_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "collectionId=" + collectionId
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  collectionPost  = try JSONDecoder().decode(OtherContentListTwo.self,from: responseData)
            
                completionHandler(collectionPost,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getFeedsOfCollectionThree(_ collectionId :String , completionHandler: @escaping (OtherContentListThree?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/contributions_of_a_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "collectionId=" + collectionId
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  collectionPost  = try JSONDecoder().decode(OtherContentListThree.self,from: responseData)
                
                completionHandler(collectionPost,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getFeedsOfCollectionTwo(_ collectionId :String , completionHandler: @escaping (OtherContentListTwo?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/contributions_of_a_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "collectionId=" + collectionId
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  collectionPost  = try JSONDecoder().decode(OtherContentListTwo.self,from: responseData)
                
                completionHandler(collectionPost,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getLikes(_ per_page: Int ,_ current_page: Int,_ owner:String , completionHandler: @escaping (LikeList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/my_notifications"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
          let postString = "itemPerPage=" + String(per_page) + "&currentPage=" + String(current_page) + "&owner=" + owner
        
         urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(LikeList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func getConversation(_ per_page: Int ,_ current_page: Int,_ owner:String , completionHandler: @escaping (ConversationResponse?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/acceptedMessage"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "perPage=" + String(per_page) + "&page=" + String(current_page) + "&owner=" + owner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
            
 
                let  contentL  = try JSONDecoder().decode(ConversationResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func acceptMessage(_ sender_owner: String ,_ acceptedOwner:String , completionHandler: @escaping (NormalResponse?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/acceptRequest"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "sender_ownersender_owner=" + sender_owner + "&acceptedOwner=" + acceptedOwner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                
                
                let  contentL  = try JSONDecoder().decode(NormalResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func deleteMessage(_ sender_owner: String ,_ acceptedOwner:String , completionHandler: @escaping (NormalResponse?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/deleteRequest"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "sender_owner=" + sender_owner + "&deletedOwner=" + acceptedOwner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                
                
                let  contentL  = try JSONDecoder().decode(NormalResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getRequestedConversation(_ per_page: Int ,_ current_page: Int,_ owner:String , completionHandler: @escaping (RequestedResponse?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/requestedMessage"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "perPage=" + String(per_page) + "&page=" + String(current_page) + "&owner=" + owner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                
                
                let  contentL  = try JSONDecoder().decode(RequestedResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getMyResources(_ ownerId: String ,_ currentPage: Int,_ itemPerPage:Int , completionHandler: @escaping (ResourceList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/resources"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "itemPerPage=" + String(itemPerPage) + "&currentPage=" + String(currentPage) + "&ownerId=" + ownerId
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                
                
                let  contentL  = try JSONDecoder().decode(ResourceList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func getMyResourcesCollection(_ ownerId: String ,_ collectionId: String, completionHandler: @escaping (ResourceList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/resources_of_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "ownerId=" + ownerId + "&collectionId=" + collectionId 
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                
                
                let  contentL  = try JSONDecoder().decode(ResourceList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getChatList(_ per_page: Int ,_ current_page: Int,_ owner:String ,_ reciverOwner : String , completionHandler: @escaping (ChatList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/chatList"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "perPage=" + String(per_page) + "&page=" + String(current_page) + "&owner=" + owner + "&receiverOwner="+reciverOwner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(ChatList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    
    static func sendMessage(_ message: String ,_ owner:String ,_ reciverOwner : String , completionHandler: @escaping (errorMessage?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/send_message"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "message=" + message + "&sender_owner=" + owner + "&receiver_owner=" + reciverOwner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(errorMessage.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func deleteCollection(_ owner:String ,_ collectionId : String , completionHandler: @escaping (errorMessage?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/delete_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&collectionId=" + collectionId;
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                let  contentL  = try JSONDecoder().decode(errorMessage.self,from: responseData)
                completionHandler(contentL,nil)
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    
    static func deleteContent(_ owner:String ,_ contentId : String , completionHandler: @escaping (errorMessage?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/delete_contribution"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&contributionId=" + contentId;
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                let  contentL  = try JSONDecoder().decode(errorMessage.self,from: responseData)
                completionHandler(contentL,nil)
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    
    static func userInfo(_ owner: String ,_ userInfo:String , completionHandler: @escaping (UserInfo?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/userInfo"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + userInfo + "&userInfo=" + owner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(UserInfo.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    
    static func collectionInfo(_ collectionId:String,_ buyerId : String , completionHandler: @escaping (ColInfo?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/collectionInfo"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "collectionId=" + collectionId + "&buyerId=" + buyerId
        
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(ColInfo.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    
    static func editProfile(_ profileId: String ,_ first_name:String ,_ last_name : String ,_ job_position :String , _ city :String ,_ bio : String , completionHandler: @escaping (errorMessage?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/edit_profile"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
       
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "profileId=" + profileId + "&first_name=" + first_name + "&last_name=" + last_name + "&job_position=" + job_position + "&city=" + city + "&bio=" + bio
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(errorMessage.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func saverOfContributionList(_ owner: String ,_ contributionId : String ,completionHandler: @escaping (SeverList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/savers_of_contribution"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&contributionId=" + contributionId
        
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(SeverList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func collectionFollowers(_ collectionId: String  ,completionHandler: @escaping (CollectionFollowerList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/followers_of_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "collectionId=" + collectionId 
        
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(CollectionFollowerList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func search(_ search: String ,completionHandler: @escaping (SearchList?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/search"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "txtforsearch=" + search
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error!)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            // parse the result as JSON
            // then create a Todo from the JSON
            do {
                
                
                let  contentL  = try JSONDecoder().decode(SearchList.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func addLabel(_ owner : String , _ collectionId : String , _ labeles : String,completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        
        let endpoint = "https://mycareerclue.com/api/add_label"
        
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&collectionId=" + collectionId + "&labels=" + labeles
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
    
        
        
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
                let  contentL  = try JSONDecoder().decode(NormalResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    static func addLabelContribution(_ owner : String , _ contributionId : String , _ labeles : String,completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        
        let endpoint = "https://mycareerclue.com/api/add_label_contribution"
        
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&contributionId=" + contributionId + "&labels=" + labeles
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        
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
                let string1 = String(data: responseData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                let  contentL  = try JSONDecoder().decode(NormalResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    static func addLabelChapter(_ owner : String , _ chapterId : String , _ labeles : String,completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        
        let endpoint = "https://mycareerclue.com/api/add_label_chapter"
        
        
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner + "&chapterId=" + chapterId + "&labels=" + labeles
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
        
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
                let string1 = String(data: responseData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                let  contentL  = try JSONDecoder().decode(NormalResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    static func likeAndDisLike(_ like_status: Int ,_ liker_id: String,_ postId:String , liked_id : String , completionHandler: @escaping (Int?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/like_dislike"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "like_status=" + String(like_status) + "&liker_id=" + liker_id + "&postId=" + postId + "&liked_id=" + liked_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
            
                print(responseData)
                
                completionHandler(1,nil)
                
            
        })
        task.resume()
        
        
    }
    
    
    
    static func followDisFollow(_ follow_status: Int ,_ follower_id: String,_ followed_id : String , completionHandler: @escaping (Int?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/follow_unfollow"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "follow_status=" + String(follow_status) + "&follower_id=" + follower_id + "&followed_id=" + followed_id
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
            
            print(responseData)
            
            completionHandler(1,nil)
            
            
        })
        task.resume()
        
        
    }
    
    static func followDisFollowCollection(_ follow_status: Int ,_ follower_id: String,_ collectionId : String , completionHandler: @escaping (Int?, Error?) -> Void) {
        let endpoint = "https://mycareerclue.com/api/follow_unfollow_collection"
        guard let url = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "follow_status=" + String(follow_status) + "&follower_id=" + follower_id + "&collectionId=" + collectionId
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
            
            print(responseData)
            
            completionHandler(1,nil)
            
            
        })
        task.resume()
        
        
    }
    static func signIn(_ first_name:String,_ last_name : String ,
                       _ mobile : String ,_ email_address : String,_ job_position : String ,_ password : String ,_ country : String  , completionHandler : @escaping (RegisterResponse?,Error?)->Void ){
        let endPoint = "https://mycareerclue.com/api/signup"
        guard let url = URL(string: endPoint)
            else
        {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "first_name=" + first_name + "&last_name=" + last_name  + "&mobile=" + mobile + "&email_address=" + email_address + "&job_position=" + job_position + "&password=" + password + "&country=" + country
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(RegisterResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
   
    static func getNotif(_ owner:String, completionHandler : @escaping (NotifResponse?,Error?)->Void ){
        let endPoint = "https://mycareerclue.com/api/notif_status/"
        guard let url = URL(string: endPoint)
            else
        {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = "owner=" + owner
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(NotifResponse.self,from: responseData)
                completionHandler(contentL,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
        
    }
    static func getLabeles( completionHandler : @escaping (LabelResponse?,Error?)->Void ){
        let endPoint = "https://mycareerclue.com/api/labels/"
        guard let url = URL(string: endPoint)
            else
        {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let postString = ""
        
        urlRequest.httpBody = postString.data(using: String.Encoding.utf8)
        
        
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
                let  contentL  = try JSONDecoder().decode(LabelResponse.self,from: responseData)
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
        let endpoint = "https://mycareerclue.com/api/login/"
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
    
    
    
    static func addPrice(_owner : String , _collectionId : String , _price : String , _currency : String , _desc : String,completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/add_price"
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
        postString.append("price=")
        postString.append(_price)
        postString.append("&collectionId=")
        postString.append(_collectionId)
        postString.append("&owner=")
        postString.append(_owner)
        
        postString.append("&currency=")
        postString.append(_currency)
        postString.append("&description=")
        postString.append(_desc)
       
        
        
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
 
    
    static func payment(_owner : String , _StripeApiKey : String ,_stripeToken :String ,_collectionId : String,_requested_by : String,_price : String,_cur_en :String ,_cur_fa : String ,_buyer : String , completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/pay_via_stripe"
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
        postString.append("stripeApiKey=")
        postString.append(_StripeApiKey)
        postString.append("&owner=")
        postString.append(_owner)
        postString.append("&stripeToken=")
        postString.append(_stripeToken)
        postString.append("&collectionId=")
        postString.append(_collectionId)
        postString.append("&requested_by=")
        postString.append(_requested_by)
        postString.append("&price=")
        postString.append(_price)
        postString.append("&cur_en=")
        postString.append(_cur_en)
        postString.append("&cur_fa=")
        postString.append(_cur_fa)
        postString.append("&buyer=")
        postString.append(_buyer)
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
    static func addLink(_owner : String , _link : String ,completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        let endpoint = "https://mycareerclue.com/api/dedicated_link"
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
        postString.append("dedicated_id=")
        postString.append(_link)
        postString.append("&owner=")
        postString.append(_owner)
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
    
    static func generateBundry() -> String {
        
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    static func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        
        let filename = "user-profile.png"
        let mimetype = "image/png"
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imageDataKey)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        return body as Data
    }
    static func uploadImageToCollection(imageData: Data?, parameters: [String : String], completionHandler: @escaping (Int?, Error?) -> Void){
        
        let endpoint = "https://mycareerclue.com/api/upload_contribution_photo" /* your API url */
        let myUrl = URL(string: endpoint)
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST"
        let boundry = generateBundry()
        request.setValue("multipart/form-data; boundary=\(boundry)", forHTTPHeaderField: "Content-Type")
       
        request.httpBody = createBodyWithParameters(parameters: parameters, filePathKey: "file", imageDataKey: imageData!, boundary: boundry)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                print(json)
                
               completionHandler(1, nil)
                
            }catch
            {
                completionHandler(nil, error)
                return
            }
            
        }
        
        task.resume()
        
        
   
    }
    
 
    static func uploadImageToProfile(imageData: Data?, parameters: [String : Any], completionHandler: @escaping (ProfileImageUpdateObject?, Error?) -> Void){
        
        let endpoint = "https://mycareerclue.com/api/upload_profile_photo" /* your API url */
        let myUrl = URL(string: endpoint)
        var request = URLRequest(url:myUrl!);
        request.httpMethod = "POST"
        let boundry = generateBundry()
        request.setValue("multipart/form-data; boundary=\(boundry)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBodyWithParameters(parameters: parameters as? [String : String], filePathKey: "file", imageDataKey: imageData!, boundary: boundry)
        
        
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error != nil {
                return
            }
            
            // You can print out response object
            
            // Print out reponse body
            guard let responseData = data else {
                print("Error: did not receive data")
                let error = BackendError.objectSerialization(reason: "No data in response")
                completionHandler(nil, error)
                return
            }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                let  resp  = try JSONDecoder().decode(ProfileImageUpdateObject.self,from: responseData)
                completionHandler(resp, nil)
                
            }catch
            {
                completionHandler(nil, error)
                return
            }
            
        }
        
        task.resume()
    }
    
    static func getChapters(owner: String  , completionHandler: @escaping (CollChap?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://mycareerclue.com/api/my_collections_plus_chapters"
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
                let string1 = String(data: responseData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                let  resp  = try JSONDecoder().decode(CollChap.self,from: responseData)
                completionHandler(resp,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
   
    
   
    static func editFeed(contributionId : String,owner: String ,collectionId : String, title : String , description : String ,  isPublic : Int, isRtl : Int ,contentType : String,link : String , completionHandler: @escaping (NormalResponse?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://mycareerclue.com/api/edit_contribution/"
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
        postString.append("contributionId=")
        postString.append(contributionId)
        postString.append("&owner=")
        postString.append(owner)
        postString.append("&collectionId=")
        postString.append(collectionId)
        postString.append("&contentType=")
        postString.append(contentType)
        postString.append("&isPublic=")
        postString.append(String(isPublic))
        let b = "&title="
        postString.append(b)
        postString.append(title)
        postString.append("&isRtl=")
        postString.append(String(isRtl))
        postString.append("&isPublic=")
        postString.append(String(1))
        postString.append("&description=")
        postString.append(description)
        postString.append("&link=")
        postString.append(link)
        
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
                let string1 = String(data: responseData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
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
    
    static func saveFeed(owner: String ,collectionId : String, title : String , description : String ,  isPublic : Int, isRtl : Int ,contentType : String,link : String , completionHandler: @escaping (AddContributionRes?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://mycareerclue.com/api/add_contribution/"
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
        postString.append("&collectionId=")
        postString.append(collectionId)
        postString.append("&contentType=")
        postString.append(contentType)
        postString.append("&isPublic=")
        postString.append(String(isPublic))
        let b = "&title="
        postString.append(b)
        postString.append(title)
        postString.append("&isRtl=")
        postString.append(String(isRtl))
        postString.append("&isFree=")
        postString.append(String(1))
        postString.append("&description=")
        postString.append(description)
        postString.append("&link=")
        postString.append(link)
        
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
                let string1 = String(data: responseData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                let  resp  = try JSONDecoder().decode(AddContributionRes.self,from: responseData)
                completionHandler(resp,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    static func saveChapter(owner: String ,collectionId : String, title : String , description : String ,  isPublic : Int, isRtl : Int ,link : String , completionHandler: @escaping (AddChapterRes?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://mycareerclue.com/api/add_chapter"
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
        postString.append("&collectionId=")
        postString.append(collectionId)
        postString.append("&isPublic=")
        postString.append(String(isPublic))
        let b = "&title="
        postString.append(b)
        postString.append(title)
        postString.append("&isRtl=")
        postString.append(String(isRtl))
        postString.append("&isFree=")
        postString.append(String(1))
        postString.append("&description=")
        postString.append(description)
        postString.append("&link=")
        postString.append(link)
        
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
                let string1 = String(data: responseData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                let  resp  = try JSONDecoder().decode(AddChapterRes.self,from: responseData)
                completionHandler(resp,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    static func saveCollection(owner: String , title : String , description : String ,  isPublic : Int, isRtl : Int ,link : String , completionHandler: @escaping (AddCollectionResp?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://mycareerclue.com/api/add_collection"
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
        postString.append("&isPublic=")
        postString.append(String(isPublic))
        let b = "&title="
        postString.append(b)
        postString.append(title)
        postString.append("&isRtl=")
        postString.append(String(isRtl))
        
        postString.append("&description=")
        postString.append(description)
        postString.append("&link=")
        postString.append(link)
       
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
                let  resp  = try JSONDecoder().decode(AddCollectionResp.self,from: responseData)
                completionHandler(resp,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
    static func editCollection(owner: String , collectionId : String, title : String , description : String ,  isPublic : Int, isRtl : Int ,link : String , completionHandler: @escaping (errorMessage?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://mycareerclue.com/api/edit_collection"
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
        postString.append("&isPublic=")
        postString.append(String(isPublic))
        postString.append("&collectionId="+collectionId)
        let b = "&title="
        postString.append(b)
        postString.append(title)
        postString.append("&isRtl=")
        postString.append(String(isRtl))
        
        postString.append("&description=")
        postString.append(description)
        postString.append("&link=")
        postString.append(link)
        
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
                let  resp  = try JSONDecoder().decode(errorMessage.self,from: responseData)
                completionHandler(resp,nil)
                
            } catch {
                // error trying to convert the data to JSON using JSONSerialization.jsonObject
                completionHandler(nil, error)
                return
            }
        })
        task.resume()
        
    }
   static func makeQaList() -> [QA] {
        var qaQastions = [QA]()
        qaQastions.append(QA(title: "Why am I invited?", description: "We truly value the feedback of the first users of our system. Your feedback will be evaluated by our technical teams hence fixing up the issues, making it function smoother"))
    
        qaQastions.append(QA(title: "Can I really make money?", description: "100%. Our community consists of 20,000 experts and students who are eager to learn the latest and the most up-to-date lessons from others who work in the same field as theirs."))
    
        qaQastions.append(QA(title: "Who owns mycareerclue.com?", description: "Mehran Shafiei and Rasoul Bahmani, living in Melbourne, Australia own mycareerclue.com and IT BOOST Australia is responsible for getting everything up and running"))
    
        qaQastions.append(QA(title: "Resources Management", description: "Resources work the same way as tags or hashtags in other systems do. They help connect relevant contents and display on the same page. When you add a resource to your contribution, it will be saved in your resources library for future use. People, Companies, Books, etc are the resource types you can choose to include in your resources management section."))
        return qaQastions
    }
    
    
    
}
