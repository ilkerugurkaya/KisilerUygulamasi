//
//  Kisilerdao.swift
//  Kişiler Uygulaması
//
//  Created by İlker Kaya on 2.12.2022.
//

import Foundation

class Kisilerdao {
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask,true).first!
        let veriTabani = URL(fileURLWithPath: hedefYol).appendingPathComponent("kisiler.sqlite")
        db = FMDatabase(path: veriTabani.path)
    }
    func kisiEkle(kisi_ad:String,kisi_tel:String){
        
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO kisiler(kisi_ad,kisi_tel) values (?,?)", values: [kisi_ad,kisi_tel])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func tumKisilerAl() -> [Kisiler]{
        var liste = [Kisiler]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("Select * From kisiler", values: nil)
            
            while rs.next(){
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_tel: Int(rs.string(forColumn: "kisi_tel")!)!)
                liste.append(kisi)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste

    }
    
    func kisiSil(kisi_id:Int){
        
        db?.open()
        
        do {
            try db!.executeUpdate("DELETE FROM kisiler WHERE kisi_id = ?", values: [kisi_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func aramaYap(kisi_ad: String) -> [Kisiler]{
        
        var liste = [Kisiler]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kisiler WHERE kisi_ad like '%\(kisi_ad)&'", values: nil)
            
            while rs.next(){
                let kisi = Kisiler(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_tel: Int(rs.string(forColumn: "kisi_tel")!)!)
                
                liste.append(kisi)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
}
