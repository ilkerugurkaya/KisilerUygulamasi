//
//  ViewController.swift
//  Kişiler Uygulaması
//
//  Created by İlker Kaya on 29.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var kisilerTableView: UITableView!
    
    var kisilerListe = [Kisiler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        veritabaniKopyala()
        
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        searchbar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        kisilerListe = Kisilerdao().tumKisilerAl()
        kisilerTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            
        }
        if segue.identifier == "toGuncelle" {
            
        }
    }
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "kisiler", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first!
        
        let fileManager = FileManager.default
        
        let kopyanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
        
        if fileManager.fileExists(atPath: kopyanacakYer.path){
            print("Veritabanı zaten var kopyalamaya gerek yok")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyanacakYer.path)
            }catch{
                print(error)
            }
        }
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListe.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
        cell.kisiYaziLabel.text = "\(kisi.kisi_ad!) - \(kisi.kisi_tel!)"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in
            
        }
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") { (contextualAction, view, boolValue) in
        
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
    }
}


extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama Sonuc : \(searchText)")
    }
    
}
