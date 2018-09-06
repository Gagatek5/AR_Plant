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
    let test = Time.instance
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

        test.timer(sceneView: sceneView)
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        let request = GADRequest()
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        request.testDevices = [kGADSimulatorID, "8e48301d1f7226954ef508429ed14001"]
        GADRewardBasedVideoAd.sharedInstance().load(request, withAdUnitID: "ca-app-pub-5264924694211893/6565369937")
        
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
        
//        let counter:Float = 0.0002
//        let plant = (self.sceneView.scene.rootNode.childNode(withName: testPlant.plantNodeString, recursively: false))!
//        plant.scale = SCNVector3Make(Float(plant.scale.x + counter), Float(plant.scale.y + counter), Float(plant.scale.z + counter))

    }

    func autoRiseDown(){
        //lastNode.last??.removeFromParentNode()
        
    }
    
    func randomNumber(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
        
    }
    @IBAction func removeNode(_ sender: Any) {
        sceneView.scene.rootNode.removeFromParentNode()
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
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd, didRewardUserWith reward: GADAdReward) {
        
        Plant.instance.pests.removeAll()
        print(Plant.instance.pests)
        
    }

}


