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
            // can the device monitor iBeacons?
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                // is ranging available? ranging is the abiliity to tell roughly how far something else
                // is away from the device
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }

    // this method detects all the beacons in a given region
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        // is any beacon received?
        if beacons.count > 0 {
            // fetch the first beacon
            let beacon = beacons[0]
            // update the label and background color based on the proximity property
            updateDistance(beacon.proximity)
        } else {
            // no beacon: change label to "UNKNOWN" and background color to gray
            updateDistance(.Unknown)
        }
    }

    func startScanning() {
        // convert a string into a UUID
        let uuid = NSUUID(UUIDString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        // must enter major of 123 and minor of 456 into the Locate Beacon app on my iPad
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")

        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }

    // this method will change the label text and view background color to reflect proximity
    // to the beacon we're scanning for
    func updateDistance(distance: CLProximity) {
        UIView.animateWithDuration(0.8) { [unowned self] in
            // CLProximity can only be one of four distance values, so there's no need for a default case
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                self.distanceReading.text = "UNKNOWN"

            case .Far:
                self.view.backgroundColor = UIColor.blueColor()
                self.distanceReading.text = "FAR"

            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                self.distanceReading.text = "NEAR"

            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
                self.distanceReading.text = "RIGHT HERE"
            }
        }
    }
}

