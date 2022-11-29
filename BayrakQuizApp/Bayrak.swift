//
//  Bayrak.swift
//  BayrakQuizApp
//
//  Created by Selim on 28.11.2022.
//

import Foundation

class Bayrak:Equatable,Hashable{
    
    static func == (lhs: Bayrak, rhs: Bayrak) -> Bool {
        return lhs.bayrak_id == rhs.bayrak_id
    }
    
//    var hashValue: Int{
//        get{
//            return bayrak_id.hashValue
//        }
//    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(bayrak_id?.hashValue)
    }
    
    var bayrak_id:Int?
    var bayrak_ad:String?
    var bayrak_resim:String?
    
    init(){
        
    }
    
    init(bayrak_id:Int,bayrak_ad:String,bayrak_resim:String) {
        self.bayrak_id = bayrak_id
        self.bayrak_ad = bayrak_ad
        self.bayrak_resim = bayrak_resim
    }
    
    
}
