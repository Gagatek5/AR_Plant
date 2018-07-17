//
//  ViewController.swift
//  ARPlantEngine
//
//  Created by Dave Szczutkowski on 16/06/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var wateringL: UILabel!
    @IBOutlet weak var healthL: UILabel!
    @IBOutlet weak var insolationL: UILabel!
    @IBOutlet weak var pestsL: UILabel!
    @IBOutlet weak var riseL: UILabel!
    @IBOutlet weak var plantLevelL: UILabel!
    let testPlant = Plant.init(name: Plants.cactus)
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNService.shared.authorize() 
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        setupNewPlant()
        var timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {
            (_) in
            self.testPlant.watering -= 2
            self.testPlant.rise = self.testPlant.riseUp(rise: self.testPlant.rise, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.health = self.testPlant.updatingHealth(health: self.testPlant.health, plantStatus: self.testPlant.currentStatus(plant: self.testPlant))
            self.testPlant.plantLevel = self.testPlant.levelUp(rise: self.testPlant.rise)
            self.updateView()
            self.triggerReminderNotification()
        }
        
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
    @IBAction func Watering(_ sender: Any) {
        testPlant.wateringPlant(plant: testPlant)
        updateView()
    }
    func updateView(){
        nameL.text = "Name:     " + testPlant.name.rawValue
        wateringL.text = "Watering: " + String(testPlant.watering)
        healthL.text = "Health:     " + String(testPlant.health)
        insolationL.text = "Insolation: " + String(testPlant.insolation)
        pestsL.text = "Peats:   " + String(testPlant.pests.count) + pestsLabelApender(pests: testPlant.pests)
        riseL.text = "Rise:     " + String(testPlant.rise)
        plantLevelL.text = "Plant level:    " + String(testPlant.plantLevel)
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
        if(testPlant.watering == 80) {
            UNService.shared.timerRequest(with: 10)
        }
    }

}

