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
        let endpoint = "https://weyoumaster.com/api/collections/"
        
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
    

    
    static func getCollectionOther(_ items_per_page : Int ,_ startPage :Int ,
                              owner : String  , userId : String ,
                              completionHandler: @escaping (CollectionOtherList?, Error?) -> Void){
        let endpoint = "https://weyoumaster.com/api/dashboard_collections"
        
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
             "&userId=" + userId
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
    
    
    
    
    static func getFeeds(_ per_page: Int ,_ current_page: Int,_ viewer_id :String , completionHandler: @escaping (ContentList?, Error?) -> Void) {
        let endpoint = "https://weyoumaster.com/api/feed"
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
    
    
    static func getUserFeed(_ per_page: Int ,_ current_page: Int,_ owner :String ,_ userId :String, completionHandler: @escaping (OtherContentList?, Error?) -> Void) {
        
        let endpoint = "https://weyoumaster.com/api/dashboard_contributions"
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
    
    static func getFeedsOfCollection(_ collectionId :String , completionHandler: @escaping (CollectionPost?, Error?) -> Void) {
        let endpoint = "https://weyoumaster.com/api/contributions_of_a_collection"
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
                let  collectionPost  = try JSONDecoder().decode(CollectionPost.self,from: responseData)
            
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
        let endpoint = "https://weyoumaster.com/api/my_notifications"
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
        let endpoint = "https://weyoumaster.com/api/acceptedMessage"
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
    
    static func getChatList(_ per_page: Int ,_ current_page: Int,_ owner:String ,_ reciverOwner : String , completionHandler: @escaping (ChatList?, Error?) -> Void) {
        let endpoint = "https://weyoumaster.com/api/chatList"
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
        let endpoint = "https://weyoumaster.com/api/send_message"
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
    
    static func userInfo(_ owner: String ,_ userInfo:String , completionHandler: @escaping (UserInfo?, Error?) -> Void) {
        let endpoint = "https://weyoumaster.com/api/userInfo"
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
    static func editProfile(_ profileId: String ,_ first_name:String ,_ last_name : String ,_ job_position :String , _ city :String ,_ bio : String , completionHandler: @escaping (errorMessage?, Error?) -> Void) {
        let endpoint = "https://weyoumaster.com/api/edit_profile"
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
    static func search(_ search: String ,completionHandler: @escaping (SearchList?, Error?) -> Void) {
        let endpoint = "https://weyoumaster.com/api/search"
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
        
        let endpoint = "https://weyoumaster.com/api/add_label"
        
        
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
        
        let endpoint = "https://weyoumaster.com/api/add_label_contribution"
        
        
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
        
        let endpoint = "https://weyoumaster.com/api/add_label_chapter"
        
        
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
        let endpoint = "https://weyoumaster.com/api/like_dislike"
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
        let endpoint = "https://weyoumaster.com/api/follow_unfollow"
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
    static func signIn(_ first_name:String,_ last_name : String ,
                       _ mobile : String ,_ email_address : String,_ job_position : String ,_ password : String ,_ country : String  , completionHandler : @escaping (RegisterResponse?,Error?)->Void ){
        let endPoint = "https://weyoumaster.com/api/signup"
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
        let endPoint = "https://weyoumaster.com/api/notif_status/"
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
        let endPoint = "https://weyoumaster.com/api/labels/"
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
        let endpoint = "https://weyoumaster.com/api/login/"
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
        let endpoint = "https://weyoumaster.com/api/add_price"
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
    
    
    
    
    static func uploadImageToCollection(imageData: Data?, parameters: [String : Any], completionHandler: @escaping (Int?, Error?) -> Void){
        
        let endpoint = "https://weyoumaster.com/api/upload_collection_photo" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
       
        guard let myUrl = URL(string: endpoint)
            else {
                print("Error: cannot create URL")
                let error = BackendError.urlError(reason: "Could not construct URL")
                completionHandler(nil, error)
                return
        }
        
        var urlRequest = URLRequest(url: myUrl)
        urlRequest.httpMethod = "POST"
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "file", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: endpoint, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseString { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        completionHandler(nil, err)
                        return
                    }
                    completionHandler(1, nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                completionHandler(nil, error)

            }
        }
    }
    
    
    static func getChapters(owner: String  , completionHandler: @escaping (CollChap?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://weyoumaster.com/api/my_collections_plus_chapters"
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
   
    
    static func saveFeed(owner: String ,collectionId : String, title : String , description : String ,  isPublic : Int, isRtl : Int ,contentType : String,link : String , completionHandler: @escaping (AddContributionRes?, Error?) -> Void){
        
        // set up URLRequest with URL
        let endpoint = "https://weyoumaster.com/api/add_contribution/"
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
        let endpoint = "https://weyoumaster.com/api/add_chapter"
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
        let endpoint = "https://weyoumaster.com/api/add_collection"
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
    
   static func makeQaList() -> [QA] {
        var qaQastions = [QA]()
        qaQastions.append(QA(title: "چرا من به این سیستم دعوت شده ام؟", description: "ما تمایل داریم با کارشناسان و مدیرانی که تجارب بین المللی دارند - همچون خود شما - ارتباط برقرار نموده و دیدگاه آنان را در رابطه با ایده اولیه ویومستر و نحوه اجرای آن بدانیم. این به ما کمک شایانی خواهد نمود تا سیستمی بی نقص را در اختیار کاربران قرار دهیم. ویومستر تمایل دارد تا فیدبک ارزشمند شما را در رابطه با میزان اثربخشی این سیستم و احتمال موفقیت آن در بین فارسی زبانان بداند"))
        
        var a = "ویومستر یا View-Master در گذشته ابزاری برای تماشای دنیای فرنگ بود. ابزاری شبیه یک دوربین که با فشردن دکمه سمت راست آن، عکس‌های داخل آن - که عمدتا تصاویر شهرهای مدرن دنیا بود - تعویض می‌شد ."
        var b = "هدف نهائی پروژه‌ای که ما به دنبال اجرایش بودیم به صورت نمادین و به طرز عجیبی، View-Master را در ذهن ما تداعی کرد ."
        
        
        var c = "دلایل مرتبط با حقوق کپی رایت، ما را مجبور نمود که نحوه نگارش ویومستر به زبان انگلیسی را کمی تغییر داده و این پروژه را به صورت WeYouMaster به دنیا معرفی نمائیم. شاید این عنوان تداعی‌گر آن باشد که ایرانیان ساکن ایران و ایرانیان مقیم خارج از کشور تنها با یکی‌شدن و اتحاد می‌توانند به قله های موفقیت برسند!"
        
        let d = a + b + c
        
        qaQastions.append(QA(title: "وی‌یو‌مستر به چه معناست؟", description: d))
        
        
        
        a = "بله ۱۰۰٪. ویومستر از طریق شبکه گسترده ۲۰ هزار نفری خود قادر خواهد بود تا برای مجموعه‌های شما بازاریابی نماید و آنها را از طریق سامانه مدیریت پرداخت حرفه‌ای خود بفروش برساند."
        b = "در هشت سال گذشته، سامانه آموزش و توسعه شرکت رافابس سیستم MeetNeed.ir حجم انبوهی از نیازهای آموزشی و دانشی کاربران خود را شناسایی و آنها را تجزیه و تحلیل نموده است. این نیازها که عمدتا توسط شرکت‌ها، سازمان‌ها و دانشجویان تولید شده است از طریق مجموعه‌ها و مشارکت‌های تولیدشده در ویومستر برآورده خواهد شد"
        
        qaQastions.append(QA(title: "آیا من واقعا می‌توانم از ویومستر درآمد داشته باشم؟", description: a + b))
        
        
        qaQastions.append(QA(title: "ویومستر متعلق به کیست؟", description: "مهران شفیعی و رسول بهمنی - ساکنین ملبورن استرالیا - از موسسان اولیه ویومستر هستند . کلیه امور مرتبط با توسعه فنی ویومستر توسط تیم توسعه رافابس سیستم Rafabece.ir توسعه و پشتیبانی می‌شود"))
        qaQastions.append(QA(title: "وی‌یو‌مستر با چه فناوری تولید شده است؟", description: "ما از فریمورک CodeIgniter برای توسعه ویومستر استفاده کرده‌ایم. زبان‌های برنامه‌نویسی PHP, Javascript و فناوری AJAX برای توسعه بکند و فرونت‌اند این وب‌اپ استفاده شده است. اگر تمایل دارید برای توسعه این سامانه و همچنین توسعه اپ‌های اندروید و iOS به ما ملحق شوید، لطفا لینک زیر را ملاحظه فرمائید . موقعیت‌های شغلی رافابس سیستم"))
        
        
        a = "در فازهای آتی این پروژه، اپ های اندروید و iOS ویومستر توسعه خواهد یافت."
        b = "\n"
        c = "ضمنا، کاربران علاوه بر فروش مجموعه ها قادر خواهند بود تا مشارکت های خود را نیز به صورت انفرادی به فروش برسانند. همچنین، کاربران قادر خواهند بود علاوه بر اشخاص، مجموعه ها را نیز رصد کنند."
        qaQastions.append(QA(title: "فازهای آتی ویومستر چه هستند؟", description: a + b + c))
        
        
        a = "نه‌تنها مدیریت برچسب‌ها کمک می‌کند تا مشارکت‌ها و مجموعه‌های مشابه در کنار یکدیگر نمایش داده شود، بلکه ویومستر پس از اضافه‌شدن یک برچسب متناسب با نوع آن - شرکت یا شخص یا مهارت - آن را به منابع شما اضافه می کند"
        b = "\n"
        c = "به عبارت دیگر ما معتقد هستیم برای ارتقا در مسیر شغلی منابع شخص باید تقویت گردد. این منابع شامل مهارت‌های شخص، شرکت‌هایی که شخص در حوزه فعالیت خود می‌شناسد و همچنین الگوهایی است که شخص از آنها ایده می‌گیرد"
        qaQastions.append(QA(title: "مدیریت برچسب‌ها چیست؟", description: a + b + c))
        return qaQastions
    }
    
    
    
}
