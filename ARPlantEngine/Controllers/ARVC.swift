//
//  ARVC.swift
//  ARPlantEngine
//
//  Created by Tom on 16/07/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit
import ARKit
import GoogleMobileAds

class ARVC: UIViewController, ARSCNViewDelegate, GADRewardBasedVideoAdDelegate {
    
    @IBOutlet weak var addRiseUpButtonO: UIButton!
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var counter:Float = 0.0
    let test = Time.init()
    let testPlant = Plant.instance
    
    var updateTimer: Timer?
    var level = 0
    var lastNode: [SCNNode?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.registerGestureRecognizers()
        self.sceneView.autoenablesDefaultLighting = true

        test.timer(timeInterval: 5)
        
        
        let requestBigAd = GADRequest()
        GADRewardBasedVideoAd.sharedInstance().delegate = self 
        requestBigAd.testDevices = [kGADSimulatorID]
        GADRewardBasedVideoAd.sharedInstance().load(requestBigAd, withAdUnitID: "ca-app-pub-5264924694211893/6565369937")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func DeleteARNode(_ sender: Any) {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode() }
    }
    
    func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        //let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        //self.sceneView.addGestureRecognizer(pinchGestureRecognizer)
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty {
            self.addItem(hitTestResult: hitTest.first!)
        }
    }
    
    func addItem(hitTestResult: ARHitTestResult) {
        if self.sceneView.scene.rootNode.childNode(withName: "plant", recursively: false) == nil
        {
            let scene = SCNScene(named: "Models.scnassets/plant.scn")
            let node = (scene?.rootNode.childNode(withName: "plant", recursively: false))!
            let transform = hitTestResult.worldTransform
            let thirdColumn = transform.columns.3
            node.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
            
            self.sceneView.scene.rootNode.addChildNode(node)
            addRiseUpButtonO.isEnabled = true
        }
        
        
    }
    @IBAction func addStalk(_ sender: Any) {
        
        let scene = SCNScene(named: "Models.scnassets/plant.scn")
        let node = (scene?.rootNode.childNode(withName: "stalk", recursively: false))!
        let plant = (self.sceneView.scene.rootNode.childNode(withName: "plant", recursively: false)?.position)!
        node.position = SCNVector3(plant.x, (plant.y + 0.07 + counter), plant.z)
        //node.eulerAngles = SCNVector3
        self.sceneView.scene.rootNode.addChildNode(node)
        counter += 0.02
    }
    func autoRiseUp(){
        let scene = SCNScene(named: "Models.scnassets/plant.scn")
        let node = (scene?.rootNode.childNode(withName: "stalk", recursively: false))!
        let plant = (self.sceneView.scene.rootNode.childNode(withName: "plant", recursively: false)?.position)!
        node.position = SCNVector3(plant.x, (plant.y + 0.07 + counter), plant.z)
        //node.eulerAngles = SCNVector3
        self.sceneView.scene.rootNode.addChildNode(node)
        counter += 0.02
        sceneView.scene.rootNode.addChildNode(node)
        
        lastNode.append(node)
    }
    func autoRiseDown(){
        lastNode.last??.removeFromParentNode()
        
    }
    
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    @IBAction func removePests(_ sender: Any) {
        if !Plant.instance.pests.isEmpty
        {
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
                
            }
        }else{
            let alert = UIAlertController(title: "uffff....", message: "Nie ma robaków do usunięcia", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
        Plant.instance.pests.removeAll()
        
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
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load. \(error)")
    }

}


