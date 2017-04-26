//
//  PostController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

protocol PostControllerDelegate {
    func reloadPosts(posts: [Post])
    func failFetchPost(error: ErrorResult)
}

final class PostController: RequestHandler {
    
    let postEndpoint = "https://jsonplaceholder.typicode.com/posts"
    
    let delegate : PostControllerDelegate?
    
    init(delegate : PostControllerDelegate?) {
        self.delegate = delegate
        super.init()
        
        startNotifier()
    }
    
    func fetchPosts() {
        RequestService().loadData(urlString: postEndpoint, completion: self.networkResult(completion: self.parser))
    }
    
    var parser : ((Result<[Post], ErrorResult>) -> Void) {
        return { postsResult in 
            
            DispatchQueue.main.async {
                switch postsResult {
                case .success(let posts) :
                    // reload data
                    print("Parser success \(posts)")
                    self.delegate?.reloadPosts(posts: posts)
                    break
                case .failure(let error) :
                    print("Parser error \(error)")
                    self.delegate?.failFetchPost(error: error)
                    break
                }
            }
            
        }
    }
    
}

extension PostController : RequestHandlerReachability {
    
    func startNotifier() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityStatusChanged),name: ReachabilityChangedNotification,object: reachability)
        
        do{
            try reachability.startNotifier()
            print("Start reachability notifier")
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    func stopNotifier() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
        print("Stop reachability notifier")
    }
    
    @objc func reachabilityStatusChanged(notitification notification: Notification) {
        
        guard let reachability = notification.object as? Reachability else { return }
        
        if reachability.isReachable {
            if reachability.isReachableViaWiFi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        } else {
            print("Network not reachable")
        }
    }
}
