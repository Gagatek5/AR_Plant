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

class ARVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    let test = Time.instance
    let testPlant = Plant.instance
    
    var level = 0
    var lastNode: [SCNNode?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    func prepareView(){
        self.sceneView.debugOptions = [ ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.configuration.planeDetection = .horizontal
        self.sceneView.session.run(configuration)
        self.registerGestureRecognizers()
        self.sceneView.autoenablesDefaultLighting = true
        
        test.timer(sceneView: sceneView)
    }

    func registerGestureRecognizers() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
        if !hitTest.isEmpty
        {
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
        }
    }
 
    @IBAction func removeNode(_ sender: Any) {
        sceneView.scene.rootNode.removeFromParentNode()
    }
    
   
    @IBAction func DeleteARNode(_ sender: Any) {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
            
        }
    }
}

extension ARVC: GADRewardBasedVideoAdDelegate {
    override func viewDidAppear(_ animated: Bool) {
        let requestBigAd = GADRequest()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        requestBigAd.testDevices = [kGADSimulatorID,"8e48301d1f7226954ef508429ed14001"]
        GADRewardBasedVideoAd.sharedInstance().load(requestBigAd, withAdUnitID: "ca-app-pub-5264924694211893/4676637417")
        
    }
    @IBAction func removePests(_ sender: Any) {
        if !Plant.instance.pests.isEmpty
        {
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {
                GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            }
        }
        else
        {
            let alert = UIAlertController(title: "uffff....", message: "Nie ma robaków do usunięcia", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
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
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didFailToLoadWithError error: Error) {
        print("Reward based video ad failed to load. \(error)")
    }
}


