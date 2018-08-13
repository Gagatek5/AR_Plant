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
   
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var nc = NotificationsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNService.shared.authorize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        setupNewPlant()
        
        nc.reminderNotification()
        
        var timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {
            (_) in
            Plant.instansce.watering -= 2
            Plant.instansce.rise = Plant.instansce.riseUp(rise: Plant.instansce.rise, plantStatus: Plant.instansce.currentStatus(plant: Plant.instansce))
            Plant.instansce.health = Plant.instansce.updatingHealth(health: Plant.instansce.health, plantStatus: Plant.instansce.currentStatus(plant: Plant.instansce))
            Plant.instansce.plantLevel = Plant.instansce.levelUp(rise: Plant.instansce.rise)
            self.updateView()
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
    @IBAction func dissmissView(_ sender: Any) {
         dismiss (animated: true, completion: nil)  
    }
    @IBAction func Watering(_ sender: Any) {
        Plant.instansce.wateringPlant(plant: Plant.instansce)
        updateView()
    }
    func updateView(){
        nameL.text = "Name:     " + Plant.instansce.name.rawValue
        wateringL.text = "Watering: " + String(Plant.instansce.watering)
        healthL.text = "Health:     " + String(Plant.instansce.health)
        insolationL.text = "Insolation: " + String(Plant.instansce.insolation)
        pestsL.text = "Peats:   " + String(Plant.instansce.pests.count) + pestsLabelApender(pests: Plant.instansce.pests)
        riseL.text = "Rise:     " + String(Plant.instansce.rise)
        plantLevelL.text = "Plant level:    " + String(Plant.instansce.plantLevel)
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

}

