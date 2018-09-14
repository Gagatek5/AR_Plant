//
//  ShopVC.swift
//  ARPlantEngine
//
//  Created by Tom on 15/08/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ShopVC: UIViewController {

    @IBOutlet weak var PlantCoinCountL: UILabel!
    @IBOutlet weak var GoldenSeedCountL: UILabel!
    @IBOutlet weak var ManureCountL: UILabel!
    @IBOutlet weak var InsectRepelentCountL: UILabel!
    @IBOutlet weak var SolarLampCountL: UILabel!
    
    let player = Player.instance
    let manure = Manure()
    let solar = SolarLamp()
    let repel = InsectRepelent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        PlantCoinCountL.text = "PlantCoin: \(player.coin.quantity)"
        GoldenSeedCountL.text = "GoldenCoin: \(player.seed.quantity)"
        ManureCountL.text = "Manure: \(player.upgradesList[0])"
        InsectRepelentCountL.text = "Repel: \(player.upgradesList[1])"
        SolarLampCountL.text = "Solar: \(player.upgradesList[2])"
    }
    
    @IBAction func BuyManure(_ sender: Any) {
        if(player.pay(price: manure.price, type: .PlantCoin))
        {
            player.upgradesList[0] += 1
            updateView()
        }
        else
        {
            showAlert()
        }
    }
    @IBAction func BuyInsectRepelent(_ sender: Any) {
        if(player.pay(price: repel.price, type: .PlantCoin))
        {
            player.upgradesList[1] += 1
            updateView()
        }
        else
        {
            showAlert()
        }
    }
    @IBAction func BuySolarLamp(_ sender: Any) {
        if(player.pay(price: solar.price, type: .PlantCoin))
        {
            player.upgradesList[2] += 1
            updateView()
        }
        else
        {
            showAlert()
        }
    }

    @IBAction func dissmissView(_ sender: Any) {
        dismiss (animated: true, completion: nil)
    }
  
    func showAlert() {
        let alert = UIAlertController(title: "Nie masz hajsu!", message: "#bieda", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK :c", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension ShopVC: GADRewardBasedVideoAdDelegate {
    override func viewDidAppear(_ animated: Bool) {
        let requestBigAd = GADRequest()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        requestBigAd.testDevices = [kGADSimulatorID, "8e48301d1f7226954ef508429ed14001"]
        GADRewardBasedVideoAd.sharedInstance().load(requestBigAd, withAdUnitID: "ca-app-pub-5264924694211893/6565369937")
    }
    @IBAction func addGoldenSeed(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true
        {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        Player.instance.add(value: Int(truncating: reward.amount), type: .GoldenSeed)
        
    }
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad has completed.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load. \(error)")
    }
}
