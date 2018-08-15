//
//  ShopVC.swift
//  ARPlantEngine
//
//  Created by Tom on 15/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit

class ShopVC: UIViewController {

    @IBOutlet weak var PlantCoinCountL: UILabel!
    @IBOutlet weak var GoldenSeedCountL: UILabel!
    @IBOutlet weak var ManureCountL: UILabel!
    @IBOutlet weak var InsectRepelentCountL: UILabel!
    @IBOutlet weak var SolarLampCountL: UILabel!
    let p = Player.instance
    let manure = Manure()
    let solar = SolarLamp()
    let repel = InsectRepelent()
    override func viewDidLoad() {
        super.viewDidLoad()
        PlantCoinCountL.text = "PlantCoin: \(p.coin.quantity)"
        GoldenSeedCountL.text = "GoldenCoin: \(p.seed.quantity)"
        ManureCountL.text = "Manure: \(p.upgradesList[0])"
        InsectRepelentCountL.text = "Repel: \(p.upgradesList[1])"
        SolarLampCountL.text = "Solar: \(p.upgradesList[2])"
    }
    @IBAction func BuyManure(_ sender: Any) {
        if(p.pay(price: manure.price, type: .PlantCoin)) {
            p.upgradesList[0] += 1
            updateView()
        } else {
            showAlert()
        }
    }
    @IBAction func BuyInsectRepelent(_ sender: Any) {
        if(p.pay(price: repel.price, type: .PlantCoin)) {
            p.upgradesList[1] += 1
            updateView()
        } else {
            showAlert()
        }
    }
    @IBAction func BuySolarLamp(_ sender: Any) {
        if(p.pay(price: solar.price, type: .PlantCoin)) {
            p.upgradesList[2] += 1
            updateView()
        } else {
            showAlert()
        }
    }
    

  
    func updateView(){
        PlantCoinCountL.text = "PlantCoin: \(p.coin.quantity)"
        GoldenSeedCountL.text = "GoldenCoin: \(p.seed.quantity)"
        ManureCountL.text = "Manure: \(p.upgradesList[0])"
        InsectRepelentCountL.text = "Repel: \(p.upgradesList[1])"
        SolarLampCountL.text = "Solar: \(p.upgradesList[2])"
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Nie masz hajsu!", message: "#bieda", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK :c", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
