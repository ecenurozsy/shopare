//
//  Kayit.swift
//  Final
//
//  Created by ECENUR on 31.01.2021.
//

import UIKit
import Alamofire

class Kayit: UIViewController {
    
    
    @IBOutlet weak var txtIsim: UITextField!
    @IBOutlet weak var txtSoyad: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!
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
    
   
    
    @IBAction func btnKayit(_ sender: UIButton) {
        let name = txtIsim.text!
        let surname = txtSoyad.text!
        let phone = txtPhone.text!
        let email = txtEmail.text!
        let pass = txtPass.text!
        //JSON eksik bilgiler olduğunda zaten bunu hata olarak döndürüyor.
        //Bunun dışında telefon numarası kontrolu, mail adresi kontrolu yapılabilir.
        if(name.count != 0 && surname.count != 0){
            if let phone = Int(phone){
                if email.contains("@"){
                    let params = [ "ref" : "5380f5dbcc3b1021f93ab24c3a1aac24", "userName" : name, "userSurname": surname, "userPhone" : String(phone), "userMail": email, "userPass": pass]
                    
                    let url = "https://jsonbulut.com/json/userRegister.php"
                    
                    AF.request(url, method: .get, parameters: params).responseJSON { (res) in
                    
                        if (res.response?.statusCode == 200) {
                
                            let user = try? JSONDecoder().decode(Register.self, from: res.data!)
                            let status = user?.user[0].durum
                            let msg = user?.user[0].mesaj
                            
                            if ( status == true ){
                                print("status==true")
                                //UserID bilgisini elimizde tutmak için.
                                let kullaniciID = user?.user[0].kullaniciID
                                UserDefaults.standard.setValue( kullaniciID, forKey: "userData")
                                self.performSegue(withIdentifier: "goProducts", sender: nil)
                            }
                            
                            else{
                                self.lblMsg.text = msg
                                self.lblMsg.alpha = 1.0
                                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                                    self.lblMsg.alpha = 0}
                                print("status==false")
                            }
                        }
                    }
                }
                else{
                    self.lblMsg.text = "Lütfen geçerli bir email adresi giriniz."
                    self.lblMsg.alpha = 1.0
                    Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                        self.lblMsg.alpha = 0}
                }
            }
            else{
                self.lblMsg.text = "Lütfen geçerli bir telefon numarası giriniz."
                self.lblMsg.alpha = 1.0
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                    self.lblMsg.alpha = 0}
                
            }
        }
        else{
            self.lblMsg.text = "Lütfen bilgilerinizi eksiksiz olarak giriniz."
            self.lblMsg.alpha = 1.0
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { (timer) in
                self.lblMsg.alpha = 0}
            
        }
        
        
    }
    

}




