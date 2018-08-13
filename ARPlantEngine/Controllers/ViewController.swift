//
//  ViewController.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

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
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
       locationManager(locationManager)
        print(locationManager)
        if locationManager.location?.coordinate.latitude != nil
        {
        location.getData(longitude: Double((locationManager.location?.coordinate.longitude)!), latitiude: Double((locationManager.location?.coordinate.latitude)!))
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
        UNService.shared.authorize() 
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        setupNewPlant() 
        
    }
    func locationManager(_ manager: CLLocationManager) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func reinstateBackgroundTask() {
        if updateTimer != nil && (backgroundTask == UIBackgroundTaskInvalid) {
            reinstateBackgroundTask()
        }
    }
    override func viewDidAppear(_ animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setupNewPlant(){
        updateView()
        
    }
    @IBAction func dissmissView(_ sender: Any) {
         dismiss (animated: true, completion: nil)  
    }
    @IBAction func Watering(_ sender: Any) {
        self.testPlant.wateringPlant(plant: self.testPlant)
        updateView()
    }
    func updateView(){
        nameL.text = "Name:     " + self.testPlant.name.rawValue
        wateringL.text = "Watering: " + String(self.testPlant.watering)
        healthL.text = "Health:     " + String(self.testPlant.health)
        insolationL.text = "Insolation: " + String(self.testPlant.insolation)
        pestsL.text = "Peats:   " + String(self.testPlant.pests.count) + pestsLabelApender(pests: self.testPlant.pests)
        riseL.text = "Rise:     " + String(self.testPlant.rise)
        plantLevelL.text = "Plant level:    " + String(self.testPlant.plantLevel)
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
    
    func triggerReminderNotification() {
        if(self.testPlant.watering == 80) {
            UNService.shared.timerRequest(with: 1)
        }
    }

}

