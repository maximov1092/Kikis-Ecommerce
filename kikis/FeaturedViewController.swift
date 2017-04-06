//
//  FeaturedViewController.swift
//  kikis
//
//  Created by Maxim on 22/12/2016.
//  Copyright © 2016 Kulvinder. All rights reserved.
//

import UIKit
import Buy
import MBProgressHUD

class FeaturedViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    fileprivate var collections = [BUYCollection]()
    fileprivate var collectionsImage = [BUYImageLink]()
    
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Featured"
        // Do any additional setup after loading the view.
        self.loadCollection()
    }

    private func loadCollection() {
        
        let spinnerActivity = MBProgressHUD.showAdded(to: self.view, animated: true);
        spinnerActivity.detailsLabel.text = "Loading..."
        
        BUYClient.sharedClient.getCollectionsPage(1) { (collection, page, done, error) in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if (collection != nil) && error == nil {
                self.collections = collection!
                print(self.collections.count)
                
                for var i in (0 ..< 5)
                {
                    self.collectionsImage.append(self.collections[i].image)
                }
                
                self.productTableView.reloadData()
            }
            else {
                print("Error fetching collections: \(error!.localizedDescription)")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.collectionsImage.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "FeaturedTableViewCell"
        
        let cell:FeaturedTableViewCell = self.productTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! FeaturedTableViewCell
        
        
        if let url = self.collectionsImage[indexPath.row].sourceURL {
            if let data = NSData(contentsOf: url) {
                cell.productImage.contentMode = .scaleToFill
                cell.productImage.image = UIImage(data: data as Data)
                cell.productImage.layer.cornerRadius = 12.0
                cell.productImage.clipsToBounds = true
            }        
        }
        
        cell.productTitle.text = self.collections[indexPath.row].title
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewControllerObj = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController
        detailViewControllerObj?.product_title = self.collections[indexPath.row].title
        
        var publisheddate = NSDate()
        var updateddate = NSDate()
        publisheddate = self.collections[indexPath.row].publishedAt as NSDate
        updateddate = self.collections[indexPath.row].updatedAt as NSDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let publisheddateString = dateFormatter.string(from: publisheddate as Date)
        let updateddateString = dateFormatter.string(from: updateddate as Date)
        
        detailViewControllerObj?.product_publishedAt = publisheddateString
        detailViewControllerObj?.product_updatedAt = updateddateString
        detailViewControllerObj?.product_imageUrl = self.collectionsImage[indexPath.row].sourceURL
        
        
        self.navigationController?.pushViewController(detailViewControllerObj!, animated: true)
        
    }

}
