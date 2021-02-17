//
//  ProductTableViewController.swift
//  Final
//
//  Created by ECENUR on 31.01.2021.
//

import UIKit
import Alamofire


class ProductTableViewController: UITableViewController{
    
    var arr: [Bilgiler]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //http://jsonbulut.com/json/product.php?ref=5380f5dbcc3b1021f93ab24c3a1aac24&start=0
        let params = [ "ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "start" : "0"]
        let url = "http://jsonbulut.com/json/product.php"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let prod_json = try? JSONDecoder().decode(ProductData.self, from: res.data!)
                self.arr = prod_json?.products[0].bilgiler
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopCell
        
        
        let item = arr![indexPath.row]
        cell.pTitle.text = item.productName
        cell.pPrice.text = item.price + "₺"
        cell.pCategory.text = item.categories[0].categoryName
        let url = URL(string: item.images[0].normal)
        let data = try! Data(contentsOf: url!)
        cell.img.image = UIImage(data: data)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arr![indexPath.row]
        performSegue(withIdentifier: "goDetail", sender: item )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if ( segue.identifier == "goDetail" ) {
            let vc = segue.destination as! Detail
            vc.item = sender as? Bilgiler
        }
    }
    
    
    @IBAction func btnGoMyOrder(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goMyOrder", sender: nil)
    }

}
