//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Sebastian on 3/1/16.
//  Copyright © 2016 Sebastian. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func loadView() {
        
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        let segmentedControll = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControll.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControll.selectedSegmentIndex = 0
        segmentedControll.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControll)
        
        segmentedControll.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        
        let topConstraint = segmentedControll.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControll.leadingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = segmentedControll.trailingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        
        let button = UIButton(type: .System)
        button.frame = CGRectMake(0, 0, 50, 50)
        button.setTitle("Locate Me", forState: .Normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        view.addSubview(button)
        
        button.addTarget(self, action: "locateTapped:", forControlEvents: .TouchUpInside)
        
        let buttonBottomConstraint = button.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor, constant: 0)
        let buttonTrailingConstraint = button.trailingAnchor.constraintEqualToAnchor(view.layoutMarginsGuide.trailingAnchor)
        
        buttonBottomConstraint.active = true
        buttonTrailingConstraint.active = true

        
    }
    
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        
        switch segControl.selectedSegmentIndex {
            
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    
    func locateTapped(button: UIButton) {
        
        //TODO: handle when auth is denied
        
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse {
            locationManager.requestWhenInUseAuthorization()
        } else {
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {

        let zoomToMapPoint = MKMapPointForCoordinate((userLocation.location?.coordinate)!)
        let zoomToMapSize = MKMapSize(width: 10000, height: 10000)
        let zoomToMapRect = MKMapRect(origin: zoomToMapPoint, size: zoomToMapSize)
        mapView.setVisibleMapRect(zoomToMapRect, animated: true)
    }
}