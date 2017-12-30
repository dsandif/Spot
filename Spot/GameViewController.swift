//
//  GameViewController.swift
//  Spot
//
//  Created by Darien Sandifer on 9/23/17.
//  Copyright © 2017 Darien Sandifer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds
class GameViewController: UIViewController,GADBannerViewDelegate {

    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if let view = self.view as! SKView? {
            
            let scene = SceneLevel_1(size: CGSize(width: self.view.frame.width, height: self.view.frame.height))
            scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            
            // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
            
            
            //instantiate the banner with desired ad size.
            bannerView = GADBannerView(adSize: kGADAdSizeBanner)
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            bannerView.rootViewController = self
            addBannerViewToView(bannerView)
            bannerView.load(GADRequest())
        }
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .
//        } else {
//            return .all
//        }
        
        return .portrait
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
