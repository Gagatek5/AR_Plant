//
//  EngineVC.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMobileAds

class EngineVC: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var wateringL: UILabel!
    @IBOutlet weak var healthL: UILabel!
    @IBOutlet weak var insolationL: UILabel!
    @IBOutlet weak var pestsL: UILabel!
    @IBOutlet weak var riseL: UILabel!
    @IBOutlet weak var plantLevelL: UILabel!
    
    let locationManager = CLLocationManager()
    let testPlant = Plant.instance
    let location = OpenWeatherAPIConnector.shared
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareLocation()
        UNService.shared.authorize()
        updateView()
    }

    func prepareLocation()
    {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        locationManager(locationManager)
        if locationManager.location?.coordinate.latitude != nil
        {
            location.getData(longitude: Double((locationManager.location?.coordinate.longitude)!), latitiude: Double((locationManager.location?.coordinate.latitude)!))
        }
    }
    
    func updateView(){
        nameL.text = "Name: \(self.testPlant.name.rawValue)"
        wateringL.text = "Watering:\(self.testPlant.watering)"
        healthL.text = "Health:\(self.testPlant.health)"
        insolationL.text = "Insolation:\(self.testPlant.insolation)"
        pestsL.text = "Peats: \(self.testPlant.pests.count) \(pestsLabelApender(pests: self.testPlant.pests))"
        riseL.text = "Rise:\(self.testPlant.rise)"
        plantLevelL.text = "Plant level:\(self.testPlant.plantLevel)"
    }
    
    func locationManager(_ manager: CLLocationManager) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    @IBAction func dissmissView(_ sender: Any) {
        dismiss (animated: true, completion: nil)
    }
    
    @IBAction func Watering(_ sender: Any) {
        self.testPlant.wateringPlant(plant: self.testPlant)
        updateView()
    }

    func pestsLabelApender(pests: [Pest]) -> String {
        var result = " "
        
        for pest in pests
        {
            result.append(pest.name)
            result.append(", ")
        }
        return result
    }
    
    @IBAction func useManure(_ sender: Any) {
        let manure = Manure.init()
        manure.use(upgradeItem: .Manure)
        updateView()
        
    }
    
    @IBAction func useRepel(_ sender: Any) {
        let insectRepelent = InsectRepelent.init()
        insectRepelent.use(upgradeItem: .InsectRepelent)
        updateView()
    }
    
    @IBAction func useSolar(_ sender: Any) {
        let solarLamp = SolarLamp.init()
        solarLamp.use(upgradeItem: .SolarLamp)
        updateView()
    }
    
    @IBAction func addPest(_ sender: Any) {
        testPlant.SpawnPests(pest: Pest.init(names: .FireAnt))
    }

    @IBAction func resetPlant(_ sender: Any) {
        testPlant.watering = 80
        testPlant.health = 100
        testPlant.insolation = 50
        testPlant.pests = []
        testPlant.rise = 1
        testPlant.plantLevel = 100
    }
}

extension EngineVC: GADRewardBasedVideoAdDelegate {
    override func viewDidAppear(_ animated: Bool) {
        let requestBigAd = GADRequest()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        requestBigAd.testDevices = [kGADSimulatorID,"8e48301d1f7226954ef508429ed14001"]
        GADRewardBasedVideoAd.sharedInstance().load(requestBigAd, withAdUnitID: "ca-app-pub-5264924694211893/4676637417")
        
    }
    @IBAction func addCoin(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }
    }
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        Player.instance.add(value: Int(truncating: reward.amount), type: .PlantCoin)
        testPlant.pests.removeAll()
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
