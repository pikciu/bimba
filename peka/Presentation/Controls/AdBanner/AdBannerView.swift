//
//  AdBannerCell.swift
//  peka
//
//  Created by Tomasz Pikć on 16/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Firebase
import Swinject
import SwinjectStoryboard

final class AdBannerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func load(viewController: UIViewController) {
        let settings = SwinjectStoryboard.defaultContainer.resolve(AdsSettings.self)!
        if settings.adsDisabled {
            return
        }
        
        backgroundColor = .clear
        
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        banner.translatesAutoresizingMaskIntoConstraints = false
        addSubview(banner)
        
        banner.topAnchor.constraint(equalTo: topAnchor).isActive = true
        banner.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        banner.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        banner.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        banner.adUnitID = Constants.AdMob.bannerUnitId
        banner.rootViewController = viewController
        banner.load(GADRequest())
    }
}
