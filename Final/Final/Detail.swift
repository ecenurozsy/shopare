//
//  Detail.swift
//  Final
//
//  Created by ECENUR on 31.01.2021.
//

import UIKit
import Alamofire

class Detail: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtDetail: UITextView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet var lblCategory: UILabel!
    
    var item : Bilgiler!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTitle.text = item.productName
        lblPrice.text = item.price + "₺"
        txtDetail.text = item.bilgilerDescription
        lblCategory.text = item.categories[0].categoryName
        let url = URL(string: item.images[0].normal)
        let data = try! Data(contentsOf: url!)
        img.image = UIImage(data: data)
        
        
    }
    
    @IBAction func btnBuy(_ sender: UIButton) {
        //customerID bilgisi telefondaki hafızadan alınacak.
        if let data = UserDefaults.standard.string(forKey: "userData"){
            let customerId = data
            Alamofire_buy(customerId: customerId, productId: item.productID)
        }
    }
    
    func Alamofire_buy(customerId:String, productId: String){
        //http://jsonbulut.com/json/orderForm.php?ref=5380f5dbcc3b1021f93ab24c3a1aac24&customerId=12&productId=12&html=12
        let params = [ "ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "customerId" : customerId, "productId": productId, "html" : productId]
        
        
        let url = "https://jsonbulut.com/json/orderForm.php"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let order = try? JSONDecoder().decode(Order.self, from: res.data!)
                
                let status = order?.order[0].durum //Durum bilgisine ulaşıyoruz.
                let message = order?.order[0].mesaj //Bunlar json yapısındaki bilgiler.
                
                if ( status == true ){
                    //Sipariş başarılı
                    let alert = UIAlertController(title: "Başarılı", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    //Sipariş Başarısız
                    let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(message!)
                }
            }
        }
    }
    
    
}
 
