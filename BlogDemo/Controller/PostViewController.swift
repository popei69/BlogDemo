//
//  PostViewController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, PostControllerDelegate, UserControllerDelegate, CommentControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    let kReusableIdentifier = "PostTableViewCell"
    
    var posts : [Post] = [] {
        didSet { 
            self.tableView.reloadData()
            
            // load users now 
            DispatchQueue.global(qos: .background).async {
                UserController(delegate: self).fetchUsers()
                CommentController(delegate: self).fetchComments()
            }
            
        }
    }
    
    var users : [User] = []
    var comments : [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Posts"
        
        PostController(delegate: self).fetchPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadPosts(posts: [Post]) {
        self.posts = posts
    }
    
    func reloadUsers(users: [User]) {
        self.users = users
    }
    
    func reloadComments(comments: [Comment]) {
        self.comments = comments
    }
    
    
}

extension PostViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kReusableIdentifier) as! PostTableViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = posts[indexPath.row]
        
        if let user = users.first(where: {$0.id == post.userId}) {
            print("Post selected: \(post.title) from \(user.name)")
        }
        
        let tmpComments = comments.filter({$0.postId == post.id})
        print("There is \(tmpComments.count) comments on this post")
    }
}
