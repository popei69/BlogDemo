//
//  PostDetailViewController.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 26/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var post : Post?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("Post detail", comment: "Post detail")
        
        if let post = post {
            print("Post selected: \(post.title) from \(post.author?.name)")
            print("There is \(post.comments.count) comments on this post")
            
            titleLabel.text = post.title.capitalized
            authorLabel.text = (post.author != nil) ? String(format: NSLocalizedString("By {author-name}", comment: "By {author-name}"), post.author!.name) : NSLocalizedString("Anonymous author", comment: "Anonymous author")
            descriptionLabel.text = post.body.capitalized
            commentsLabel.text = (post.comments.count > 0) ? String(format: NSLocalizedString("{comments} count", comment: "Already %d comments posted"), post.comments.count) : NSLocalizedString("no comments", comment: "no comments") 
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
