//
//  ViewController.swift
//  Detect-a-Beacon
//
//  Created by My Nguyen on 8/16/16.
//  Copyright © 2016 My Nguyen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var distanceReading: UILabel!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.delegate = self
        // this corresponds to the property key NSLocationAlwaysUsageDescription set earlier
        locationManager.requestAlwaysAuthorization()

        // set the view's background color to gray
        view.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // this method is invoked after the user has granted or denied access to their location
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // did the user grant access?
        if status == .AuthorizedAlways {
            // can the device montori iBeacons?
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                // is ranging available? ranging is the abiliity to tell roughly how far something else
                // is away from the device
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
}

