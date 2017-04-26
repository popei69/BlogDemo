//
//  PostViewController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, PostControllerDelegate, UserControllerDelegate, CommentControllerDelegate{
    
    let kReusableIdentifier = "PostTableViewCell"
    
    var users : [User] = []
    var comments : [Comment] = []
    var posts : [Post] = [] {
        didSet { 
            self.tableView.reloadData()
        }
    }
    
    let refreshControl = UIRefreshControl() 
    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Posts", comment: "Posts")
        
        refreshControl.addTarget(self, action: #selector(PostsViewController.fetchPosts), for: .valueChanged)
        refreshControl.tintColor = UIColor.blue
        tableView.addSubview(refreshControl)
        
        self.fetchPosts()
    }
    
    func fetchPosts() {
        PostController(delegate: self).fetchPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadPosts(posts: [Post]) {
        self.posts = posts
        self.refreshControl.endRefreshing()
        
        // load users & comments 
        DispatchQueue.global(qos: .background).async {
            UserController(delegate: self).fetchUsers()
            CommentController(delegate: self).fetchComments()
        }
    }
    
    func failFetchPost(error: ErrorResult) {
        print(error)
        
        let alertController = UIAlertController(title: NSLocalizedString("Error occured", comment: "Error occured"), message: NSLocalizedString("error while fetching data", comment: "error while fetching data"), preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Close", style: .destructive, handler: { (action) in
            
            self.refreshControl.endRefreshing()
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func reloadUsers(users: [User]) {
        self.users = users
    }
    
    func reloadComments(comments: [Comment]) {
        self.comments = comments
    }
    
    func postDetail(post: Post) -> Post {
        
        // fetch related data to 
        var finalPost = post
        finalPost.author = UserController.userById(users: self.users, id: post.userId)
        finalPost.comments = CommentController.commentsByPostId(comments: self.comments, postId: post.id)
        
        return finalPost
    }
}

// extension dedicated to tableView logic
extension PostsViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        self.presentDetailController(post: self.postDetail(post: post))
    }
}

// extension dedicated to navigation
extension PostsViewController {
    
    func presentDetailController(post: Post) {
        
        let identifier = String(describing: PostDetailViewController.self)
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: identifier) as? PostDetailViewController {
            
            viewController.post = post
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
