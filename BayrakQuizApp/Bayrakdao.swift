//
//  Bayrakdao.swift
//  BayrakQuizApp
//
//  Created by Selim on 28.11.2022.
//

import Foundation

class Bayrakdao{
    let db:FMDatabase?

    init(){
        let hedefPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let dbUrl = URL(fileURLWithPath: hedefPath).appendingPathComponent("bayrakquiz.sqlite")

        db = FMDatabase(path:dbUrl.path)
    }
    
    // 5 sorunun doğru cevaplarını çektik
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
