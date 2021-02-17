//
//  Giris.swift
//  Final
//
//  Created by ECENUR on 31.01.2021.
//

import UIKit
import Alamofire
class Giris: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSifre: UITextField!
    @IBOutlet weak var lblMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Kullanıcının bir yere tıkladığında klavyenin kapanmasını sağlamak için
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func btnGiris(_ sender: UIButton) {
        let email = txtEmail.text!
        let pass = txtSifre.text!
        Alamofire_giris(email: email, pass: pass)
    }
    
    func Alamofire_giris(email: String, pass:String) {
        //http://jsonbulut.com/json/userLogin.php?ref=5380f5dbcc3b1021f93ab24c3a1aac24&userEmail=ali@ali.com&userPass=12345&face=no
        let params = [ "ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "userEmail" : email, "userPass": pass, "face" : "no"]
        
        
        let url = "https://jsonbulut.com/json/userLogin.php?"
        AF.request(url, method: .get, parameters: params).responseJSON { (res) in
            
            if (res.response?.statusCode == 200) {
                let user = try? JSONDecoder().decode(User1.self, from: res.data!)
                let status = user?.user[0].durum
                
                if ( status == true ){
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                    print(path)
                    UserDefaults.standard.setValue(user?.user[0].bilgiler.userID, forKey: "userData")
                    self.performSegue(withIdentifier: "goProducts", sender: nil)
                }
                
                else{
                    self.lblMsg.text = "Lütfen geçerli bir kullanıcı bilgisi giriniz."
                    self.lblMsg.alpha = 1
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                        self.lblMsg.alpha = 0}
                }
            }
        }
    }
    
}

