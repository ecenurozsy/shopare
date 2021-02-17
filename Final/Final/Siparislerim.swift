//
//  Siparislerim.swift
//  Final
//
//  Created by ECENUR on 1.02.2021.
//

import UIKit
import Alamofire


class Siparislerim: UITableViewController {
    
    var orderList: [OrderListElement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("opened")
        DispatchQueue.main.async {
            if let uid = UserDefaults.standard.string(forKey: "userData"){
                print(uid)
                
                let params = [ "ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "musterilerID" : uid]
                
                let url = "https://jsonbulut.com/json/orderList.php"
                AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                    
                    if (res.response?.statusCode == 200) {
                        
                        let userOrderList = try? JSONDecoder().decode(OrderList.self, from: res.data!)
                        if let list = userOrderList?.orderList[0] {
                            self.orderList = list
                            self.tableView.reloadData()
                            
                        }
                            
                    }
                }
            }
        }
       
    }
    

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return orderList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! SiparisCell
        
        let item = orderList[indexPath.row]
        cell.lblProductName.text = item.urunAdi
        let url = URL(string: item.normal)
        let data = try! Data(contentsOf: url!)
        cell.img.image = UIImage(data: data)
        

        return cell
    }

}
 
