//
//  ViewController.swift
//  admob-tutorial-tarde
//
//  Created by Bruno Pastre on 17/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    var interAd: GADInterstitial!
    var rewardAd: GADRewardedAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.loadReward()
        
        let button = UIButton(frame: self.view.frame)
        self.view.addSubview(button)
        self.view.backgroundColor = .blue
        button.setTitle("Mostra ad", for: .normal)
        button.addTarget(self, action: #selector(self.onDisplayAd), for: .touchDown)
    }
    
    @objc func onDisplayAd() {
        self.presentReward()
    }

}

// Reward ads
extension ViewController: GADRewardedAdDelegate {
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.loadReward()
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        
        print("O player ganhou", reward.amount, reward.type)
    }
    
    func loadReward() {
        let id = "ca-app-pub-3760704996981292/6348051540"
        let testId = "ca-app-pub-3940256099942544/1712485313"
        let newAd = GADRewardedAd(adUnitID: id)
        
        newAd.load(GADRequest()) { (error) in
            if let error = error {
                print("Vixi, deu ruim! Sem ad :(", error)
                return
            }
        }
        
        self.rewardAd = newAd
        
    }
    
    func presentReward() {
        self.rewardAd.present(fromRootViewController: self, delegate: self)
    }
    
    
}



// Interstitial ads
extension ViewController: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadInterAd()
    }
    
    func loadInterAd() {
        let id = "ca-app-pub-3760704996981292/6486818199"
        let testId = "ca-app-pub-3940256099942544/4411468910"
        
        let newAd = GADInterstitial(adUnitID: id)
        
        newAd.delegate = self
        newAd.load(GADRequest())
        
        self.interAd = newAd
    }
    
    func presentInterAd() {
        
        
        guard self.interAd.isReady else { return }
        
        self.interAd.present(fromRootViewController: self)
    }
}

