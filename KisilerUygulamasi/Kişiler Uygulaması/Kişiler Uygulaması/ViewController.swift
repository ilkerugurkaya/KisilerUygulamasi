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
    
    var liste = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        liste = ["Ahmet","Ece","Gizem","Mehmet","Talat"]
        
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self
        
        searchbar.delegate = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            
        }
        if segue.identifier == "toGuncelle" {
            
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liste.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre", for: indexPath) as! KisiHucreTableViewCell
        cell.kisiYaziLabel.text = liste[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil") { (contextualAction, view, boolValue) in
            print("Sil tıklandı \(self.liste[indexPath.row])")
        }
        let guncelleAction = UIContextualAction(style: .normal, title: "Güncelle") { (contextualAction, view, boolValue) in
            print("Güncelle tıklandı \(self.liste[indexPath.row])")
            
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
