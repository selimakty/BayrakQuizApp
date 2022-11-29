//
//  SonucViewController.swift
//  BayrakQuizApp
//
//  Created by Selim on 28.11.2022.
//

import UIKit

class SonucViewController: UIViewController {

    @IBOutlet weak var sonucLabel: UILabel!
    @IBOutlet weak var sonucOranLabel: UILabel!
    var dogruSayisi:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.hidesBackButton = true
        
        if let d = dogruSayisi {
            sonucLabel.text = "\(d) DOĞRU \(5-d) YANLIŞ"
            sonucOranLabel.text = "% \(d*100/5) Başarı"
        }
        
    }
    
    @IBAction func tryAgain(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
