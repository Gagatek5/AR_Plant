//
//  ARVC.swift
//  ARPlantEngine
//
//  Created by Tom on 16/07/2018.
//  Copyright © 2018 D&T Entertainment. All rights reserved.
//

import UIKit
import ARKit

class ARVC: UIViewController, ARSCNViewDelegate {
    
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
        
        _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {
            (_) in
            if self.sceneView.scene.rootNode.childNode(withName: "plant", recursively: false) != nil
            {
                if self.level < self.testPlant.plantLevel
                {
                    self.autoRiseUp()
                }else{
                    self.autoRiseDown()
                }
                
                self.level = self.testPlant.plantLevel
            }
        }
        
        // Do any additional setup after loading the view.
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
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


