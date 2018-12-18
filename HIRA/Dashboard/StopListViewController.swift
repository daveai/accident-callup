//
//  StopListViewController.swift
//  HIRA
//
//  Created by Debashis  on 02/01/18.
//  Copyright © 2018 Debashis . All rights reserved.
//

import UIKit
import MapKit
class StopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    @IBOutlet weak var map: MKMapView!
    let coords = [  CLLocation(latitude: 42.433525, longitude: -95.538080),
                    CLLocation(latitude: 42.474818, longitude: -95.687082),
                    CLLocation(latitude: 42.557572, longitude: -95.546320)
    ];
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cell"
        var cell: RecentShiftTableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? RecentShiftTableViewCell
        if cell == nil {
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? RecentShiftTableViewCell
        }
        cell.markerView.backgroundColor = .random()
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        let CLLCoordType = CLLocationCoordinate2D(latitude: coords[0].coordinate.latitude,
                                                  longitude: coords[0].coordinate.longitude);
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(CLLCoordType, 100000, 100000)
        map.setRegion(coordinateRegion, animated: true)
        addAnnotations(coords: coords)
        // Do any additional setup after loading the view.
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
