//
//  KisiDetayVC.swift
//  Kişiler Uygulaması
//
//  Created by İlker Kaya on 29.11.2022.
//

import UIKit

class KisiDetayVC: UIViewController {

    
    @IBOutlet weak var kisiAdLabel: UILabel!
    
    @IBOutlet weak var kisiTelLabel: UILabel!
    
    var kisi: Kisiler?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi{
            kisiAdLabel.text = k.kisi_ad
            kisiTelLabel.text = k.kisi_tel
        }
    }
    

   
}
