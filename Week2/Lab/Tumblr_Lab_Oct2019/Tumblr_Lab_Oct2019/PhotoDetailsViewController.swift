//
//  PhotoDetailsViewController.swift
//  Tumblr_Lab_Oct2019
//
//  Created by Sriram Narayanan on 10/19/19.
//  Copyright © 2019 Sriram Narayanan. All rights reserved.
//
import AlamofireImage
import UIKit

class PhotoDetailsViewController: UIViewController {
    //MARK:- Properties
    var photoURL: URL?
    @IBOutlet var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let photoURL = photoURL {
            photoImageView.af_setImage(withURL: photoURL)
        }
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

}
