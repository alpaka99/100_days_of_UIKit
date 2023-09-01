//
//  ViewController.swift
//  UIKit_day_75
//
//  Created by user on 2023/08/31.
//

import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var circle: UIView!
    @IBOutlet var distanceReading: UILabel!
    var locationManager: CLLocationManager?
    var isBeaconDetected: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
        
        isBeaconDetected = false
        
        
        circle.layer.cornerRadius = 128
        circle.frame.size.width = 0.001
        circle.frame.size.height = 0.001
        
        print(circle.frame.size.width)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        guard let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5") else { return }
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if isBeaconDetected == false {
            let ac = UIAlertController(title: "Beacon Detected!", message: "", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "cancel", style: .cancel))
            present(ac, animated: true)
            
            isBeaconDetected = true
        }
        
        if let beacon = beacons.first {
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) {
            switch distance {
            case .far:
                self.view.backgroundColor = .blue
                self.distanceReading.text = "FAR"
//                self.circle.frame.size.width = 0.25
//                self.circle.frame.size.height = 0.25
                
                
            case .near:
                self.view.backgroundColor = .orange
                self.distanceReading.text = "NEAR"
//                self.circle.frame.size.width = 0.5
//                self.circle.frame.size.height = 0.5
                
            case .immediate:
                self.view.backgroundColor = .red
                self.distanceReading.text = "IMMEDIATE"
//                self.circle.frame.size.width = 1.0
//                self.circle.frame.size.height = 1.0
                
            default:
                self.view.backgroundColor = .gray
                self.distanceReading.text = "UNKNOWN"
//                self.circle.frame.size.width = 0.001
//                self.circle.frame.size.height = 0.001
            }
        }
    }
}

