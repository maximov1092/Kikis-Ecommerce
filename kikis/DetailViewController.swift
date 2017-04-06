//
//  DetailViewController.swift
//  kikis
//
//  Created by Maxim on 23/12/2016.
//  Copyright © 2016 Kulvinder. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var product_title : String!
    var product_publishedAt : String!
    var product_updatedAt : String!
    var product_imageUrl : URL!
    
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var producttitle: UILabel!
    @IBOutlet weak var productpublisheddate: UILabel!
    @IBOutlet weak var productupdateddate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Product Detail"
        
        let data = NSData(contentsOf: product_imageUrl)
        productimage.contentMode = .scaleAspectFill
        productimage.image = UIImage(data: data as! Data)
        productimage.clipsToBounds = true
        
        self.producttitle.text = product_title
        self.productpublisheddate.text = "publishedAt : " + product_publishedAt
        self.productupdateddate.text = "updatedAt : " + product_updatedAt
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
