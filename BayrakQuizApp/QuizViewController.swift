//
//  QuizViewController.swift
//  BayrakQuizApp
//
//  Created by Selim on 28.11.2022.
//

import UIKit

class QuizViewController: UIViewController {

    
    @IBOutlet weak var dogruLabel: UILabel!
    
    @IBOutlet weak var yanlisLabel: UILabel!
    
    @IBOutlet weak var soruSayisiLabel: UILabel!
    
    @IBOutlet weak var bayrakImage: UIImageView!
    
    @IBOutlet weak var buttonA: UIButton!
    
    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
    
    
    var Sorular = [Bayrak]()
    var YanlisCevaplar = [Bayrak]()
    
    var DogruCevap = Bayrak()
    
    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
     
    var siklar = [Bayrak]()
    var karisikSiklar = Set<Bayrak>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Sorular = Bayrakdao().getRandomFlags()
        
        createQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC = segue.destination as! SonucViewController
        gidilecekVC.dogruSayisi = dogruSayac
    }
    
    func createQuestion(){
        soruSayisiLabel.text = "\(soruSayac + 1). SORU"
        dogruLabel.text = "Doğru : \(dogruSayac)"
        yanlisLabel.text = "Yanlış : \(yanlisSayac)"
        
        DogruCevap = Sorular[soruSayac]
        
        bayrakImage.image = UIImage(named: DogruCevap.bayrak_resim!)
        bayrakImage.layer.borderColor = UIColor.black.cgColor
        bayrakImage.layer.borderWidth = 0.17
        
        YanlisCevaplar = Bayrakdao().getWrongFlags(bayrak_id: DogruCevap.bayrak_id!)
        
        karisikSiklar.removeAll()
        siklar.removeAll()
        
        karisikSiklar.insert(DogruCevap)
        for n in 0...2 {
            karisikSiklar.insert(YanlisCevaplar[n])
        }
        
        for i in karisikSiklar{
            siklar.append(i)
        }
        
        buttonA.setTitle(siklar[0].bayrak_ad, for: .normal)
        buttonB.setTitle(siklar[1].bayrak_ad, for: .normal)
        buttonC.setTitle(siklar[2].bayrak_ad, for: .normal)
        buttonD.setTitle(siklar[3].bayrak_ad, for: .normal)
        
    }
    
    func ControlAnswer(button:UIButton){
        if DogruCevap.bayrak_ad == button.titleLabel?.text {
            dogruSayac += 1
        }else{
            yanlisSayac += 1
        }
        
        dogruLabel.text = "Doğru : \(dogruSayac)"
        yanlisLabel.text = "Yanlış : \(yanlisSayac)"
    }
    
    func soruSayacKontrol(){
        soruSayac += 1
        
        if soruSayac != 5 {
            createQuestion()
        }else{
            performSegue(withIdentifier: "toSonuc", sender: nil)
        }
    }
    
    @IBAction func clickA(_ sender: Any) {
        ControlAnswer(button: buttonA)
        soruSayacKontrol()
    }
    
    @IBAction func clickB(_ sender: Any) {
        ControlAnswer(button: buttonB)
        soruSayacKontrol()
    }
    
    @IBAction func clickC(_ sender: Any) {
        ControlAnswer(button: buttonC)
        soruSayacKontrol()
    }
    
    @IBAction func clickD(_ sender: Any) {
        ControlAnswer(button: buttonD)
        soruSayacKontrol()
    }
    
    
    
    
}
