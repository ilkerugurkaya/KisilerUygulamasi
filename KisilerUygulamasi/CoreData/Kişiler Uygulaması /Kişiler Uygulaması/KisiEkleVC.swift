//
//  KisiEkleVC.swift
//  Kişiler Uygulaması
//
//  Created by İlker Kaya on 29.11.2022.
//

import UIKit

class KisiEkleVC: UIViewController {
    
    let context = appDelegate.persistentContainer.viewContext
    @IBOutlet weak var kisiAdTextfield: UITextField!
    
    
    @IBOutlet weak var kisiTelTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func ekle(_ sender: Any) {
        if let ad = kisiAdTextfield.text, let tel = kisiTelTextfield.text {
            let kisi = Kisiler(context: context)
            kisi.kisi_ad = ad
            kisi.kisi_tel = tel
            
            appDelegate.saveContext()
        }

        
    }
    
   
}
