//
//  StopDetailsTableViewController.swift
//  HIRA
//
//  Created by Debashis  on 02/01/18.
//  Copyright © 2018 Debashis . All rights reserved.
//

import UIKit
import MapKit
class StopDetailsTableViewController: UITableViewController, MKMapViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var map: MKMapView!
    let coords = [
        CLLocation(latitude: 42.433525, longitude: -95.538080)
    ];
    override func viewDidLoad() {
        super.viewDidLoad()
        let CLLCoordType = CLLocationCoordinate2D(latitude: coords[0].coordinate.latitude,
                                                  longitude: coords[0].coordinate.longitude);
        map.delegate = self
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLCoordType, 100000, 100000)
        map.setRegion(coordinateRegion, animated: true)
        addAnnotations(coords: coords)
    }
    func addAnnotations(coords: [CLLocation]){
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
                                                      longitude: coord.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            map.addAnnotation(anno);
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "map_pin"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "map_pin")
        }
        
        return annotationView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 12
    }

}
