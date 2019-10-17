//
//  PhotosViewController.swift
//  Tumblr_Lab_Oct2019
//
//  Created by Sriram Narayanan on 10/12/19.
//  Copyright © 2019 Sriram Narayanan. All rights reserved.
//

import AlamofireImage
import UIKit

class PhotosViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    // MARK: - Properties
    var posts: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        retrievePosts()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Private Functions
    
    private func retrievePosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                print(dataDictionary)
                let responseDictionary = dataDictionary["response"] as! [String:Any]
            // TODO: Get the posts and store in posts property
                self.posts = responseDictionary["posts"] as! [[String:Any]] //[[]] is an array of dictionaries
                self.tableView.reloadData()
                //print(self.posts.count)
            //TODO: Reload the table view
            }
        }
        task.resume()
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return posts.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String : Any]] {
            let photo = photos[0]
            
            let originalSize = photo["original_size"] as! [String: Any]
            
            let urlString = originalSize["url"] as! String
            
            let url = URL(string: urlString)
            
            cell.photoImageView.af_setImage(withURL: url!)
        }
        return cell
    }
}
