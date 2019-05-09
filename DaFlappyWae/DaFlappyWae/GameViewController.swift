//
//  GameViewController.swift
//  DaFlappyWae
//
//  Created by Matthew Izzo on 1/19/18.
//  Copyright © 2018 Matthew Izzo. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import Firebase

class GameViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = "ca-app-pub-7730581930337030/6318052451"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.ignoresSiblingOrder = false
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "brazilsamba", ofType: "mp3")!))
        }
        catch{
            print(error)
        }
        audioPlayer.setVolume(0.3, fadeDuration: 0.1)
        var i = 0
        repeat{
            audioPlayer.play()
            i = i+1
        } while i<1000
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
