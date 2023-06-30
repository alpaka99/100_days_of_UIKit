//
//  ViewController.swift
//  UIKit_day_61
//
//  Created by user on 2023/06/30.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    
    enum MapType: String {
        case Standard
        case Satellite
        case Hybrid
        case SatelliteFlyover
        case HybridFlyover
        case MutedStandard
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
        
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        title = "Standard"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changeMapType))
    }
    
    @objc func changeMapType() {
        let ac = UIAlertController(title: "Choose map type", message: "", preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "SatelliteFlyover", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "HybridFlyover", style: .default, handler: setMapType))
        ac.addAction(UIAlertAction(title: "MutedStandard", style: .default, handler: setMapType))
        
        present(ac, animated: true)
    }
    
    func setMapType(_ action: UIAlertAction? = nil) {
        guard let actionTitle = action?.title else { return }
        
        switch actionTitle {
        case MapType.Standard.rawValue:
            mapView.mapType = .standard
            title = MapType.Standard.rawValue
            
        case MapType.Satellite.rawValue:
            mapView.mapType = .satellite
            title = MapType.Satellite.rawValue
            
        case MapType.Hybrid.rawValue:
            mapView.mapType = .hybrid
            title = MapType.Hybrid.rawValue
            
        case MapType.SatelliteFlyover.rawValue:
            mapView.mapType = .satelliteFlyover
            title = MapType.SatelliteFlyover.rawValue
            
        case MapType.HybridFlyover.rawValue:
            mapView.mapType = .hybridFlyover
            title = MapType.HybridFlyover.rawValue
            
        case MapType.MutedStandard.rawValue:
            mapView.mapType = .mutedStandard
            title = MapType.MutedStandard.rawValue
            
        default:
            mapView.mapType = .standard
            title = MapType.Standard.rawValue
        }
    }


    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 1. 만약 annotation 이 Captital 이 아니라면? -> 탈출
        guard annotation is Capital else { return nil }
        
        // 2. 재사용할 identifier 를 설정함
        let identifier = "Capital"
        
        // 3. mapview 로 부터 사용하지 않은 annotation 을 deque 함
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        
        

        
        // 4. 만약 재사용 가능한 view 를 찾지 못한다면, MKMapMarkerAnnotation 을 이용해서 새로운것을 하나 만든다. 그리고 그것의 canShowCallout 을 true 로 해준다. 이것을 해주면 도시 이름을 pop-up 해준다.
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.pinTintColor = UIColor.blue
            
            // 5..detailDisclosure type 을 이용해서 새로운 UIButton 을 만든다.
            let btn = UIButton(type: .detailDisclosure)
            annotationView?.rightCalloutAccessoryView = btn
        } else {
            // 6. 만약 재사용 가능한 view 라면? -> 해당 view 를 새로운 annotation 으로 update 한다.
            annotationView?.annotation = annotation
        }
        
//        let newAnnotationView = annotationView as? MKPinAnnotationView
//        newAnnotationView?.tintColor = UIColor(ciColor: .blue)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else { return }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController
        
        guard let viewController = vc else { return }
        
        viewController.capital = capital
        
        navigationController?.pushViewController(viewController, animated: true)
//
//        let placeName = capital.title
//        let placeInfo = capital.info
//
//        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
    }
}

