//
//  Bayrakdao.swift
//  BayrakQuizApp
//
//  Created by Selim on 28.11.2022.
//

// bu sınıfta veri tabanı işlemlerini yapıyoruz. db deki verilere bu sınıf sayesinde erişebiliyoruz


import Foundation

class Bayrakdao{
    let db:FMDatabase?

    // sınıf tanımlandığı yerde db bilgilerini alıyoruz
    init(){
        let hedefPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbUrl = URL(fileURLWithPath: hedefPath).appendingPathComponent("bayrakquiz.sqlite")

        db = FMDatabase(path:dbUrl.path)
    }
    
    // db ye bağlanıp 5 sorunun doğru cevaplarını çektik sonraasında db bağlantısını kapattık
    func getRandomFlags() -> [Bayrak] {
        
        var retval = [Bayrak]()
        
        db?.open()
        
        do{
            
            let rs = try db!.executeQuery("SELECT * FROM BAYRAKLAR ORDER BY RANDOM() LIMIT 5", values: nil)
            
            while(rs.next()){
                let bayrak = Bayrak(bayrak_id: Int(rs.string(forColumn: "bayrak_id")!)! , bayrak_ad: rs.string(forColumn: "bayrak_ad")!, bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                
                retval.append(bayrak)
            }
            
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return retval
    }
    
    // db ye bağlanıp doğru cevaptan farklı 3 ülke çektik ve db bağlantısını kapadık
    func getWrongFlags(bayrak_id:Int) -> [Bayrak] {
        
        var retval = [Bayrak]()
        
        db?.open()
        
        do{
            
            let rs = try db!.executeQuery("SELECT * FROM BAYRAKLAR WHERE bayrak_id != ? ORDER BY RANDOM() LIMIT 3", values: [bayrak_id])
            
            while(rs.next()){
                let bayrak = Bayrak(bayrak_id: Int(rs.string(forColumn: "bayrak_id")!)! , bayrak_ad: rs.string(forColumn: "bayrak_ad")!, bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                
                retval.append(bayrak)
            }
            
        }
        catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return retval
    }
}
