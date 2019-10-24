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
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfSectionsInTableView section: Int)->Int {
        return posts.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)->UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let post = posts[indexPath.count]
        if let photos = post["photos"] as? [[String : Any]] {
            let photo = photos[0]
            
            let originalSize = photo["original_size"] as! [String: Any]
            
            let urlString = originalSize["url"] as! String
            
            let url = URL(string: urlString)
            
            cell.photoImageView.af_setImage(withURL: url!)
        }
        return cell
    }
    //MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?

        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "yyyy MMM EEEE HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let timeStamp = dateFormatter.string(from: date)

        return timeStamp
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int)->UIView? {
        let headerView = UIView(frame: CGRect(x:0, y:0, width: 320, height: 50))
        headerView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y:10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15
        profileView.layer.borderColor = UIColor(white:0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1 //1 px width
        
        //Set avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        
        let post = posts[section]
        let date = post["date"] as! String
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.text = convertDateFormater(date: date)
        dateLabel.sizeToFit()
        dateLabel.frame.origin = CGPoint(x: profileView.frame.maxX + 10, y: 50 / 2 - dateLabel.frame.height/2)
        headerView.addSubview(dateLabel)
        return headerView
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailViewController = segue.destination  as! PhotoDetailsViewController
        let cell = sender as! PhotosCell
        let indexPath = tableView.indexPath(for: cell)!
        let post = posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String:Any]] {
            let photo = photos[0]
            
            let originalSize = photo["originalSize"] as! [String:Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            detailViewController.photoURL = url
        }
    }
}
