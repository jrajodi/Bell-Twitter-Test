//
//  TweetsMapViewController.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-29.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit
import MapKit
import TwitterKit
import CoreLocation

class TweetsMapViewController: UIViewController {

    @IBOutlet weak var tweetsMapView: MKMapView!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var radiusValue: UILabel!
    
    let presenter = TweetsMapPresenter()
    private var tweetsArray = [Tweet]()
    private var loadingSpinner: UIAlertController!
    let step: Float = 5
    private var radius: Int = 0
    private var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        presenter.attachView(self)
        
        loadingSpinner = getLoadingAlert()
        LocationManager.sharedInstance.delegate = self
        LocationManager.sharedInstance.startUpdatingLocation()
        
        tweetsMapView.delegate = self
        
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { timer in
            self.presenter.fetchMostRecentTweets(radius: self.radius)
        }
        
        radius = SettingsConstants.radiusValue
        radiusValue.text = "\(radius) km"
        radiusSlider.setValue(Float(radius), animated: true)
        radiusSlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        radiusSlider.isContinuous = false
        
        Defaults.shared.setInt(radius, key: SettingsConstants.radius)
    }
}

extension TweetsMapViewController: LocationManagerDelegate {
    
    func tracingLocation(currentLocation: CLLocation) {
        LocationManager.sharedInstance.stopUpdatingLocation()
        
        self.currentLocation = currentLocation
        let center = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude,
                                            longitude: currentLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                                               longitudeDelta: 0.1))
        self.tweetsMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        annotation.title = "current location"
        self.tweetsMapView.addAnnotation(annotation)
        
        tweetsMapView?.overlays.forEach { overlay in
            tweetsMapView.removeOverlay(overlay)
        }
        
        showCircle(coordinate: annotation.coordinate, radius: CLLocationDistance(radius*1000))
        presenter.fetchMostRecentTweets(radius: getRadius())
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: coordinate, radius: radius)
        tweetsMapView.addOverlay(circle)
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        showAlert(Strings.errorTitle.localized, message: error.localizedDescription)
    }
}

extension TweetsMapViewController {
    
    @objc func sliderValueDidChange(_ sender:UISlider!){
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        radius = Int(roundedStepValue)
        radiusValue.text = "\(radius) km"
        
        Defaults.shared.setInt(radius, key: SettingsConstants.radius)
        tweetsMapView?.overlays.forEach { overlay in
            tweetsMapView.removeOverlay(overlay)
        }
        showCircle(coordinate: currentLocation.coordinate, radius: CLLocationDistance(roundedStepValue*1000))
        presenter.fetchMostRecentTweets(radius: Int(roundedStepValue))
    }
    
    func showLoading() {
        show(loadingSpinner)
    }
    
    func hideLoading() {
        loadingSpinner.hide()
    }

    func reloadTweetsOnMap(data: [Tweet]) {
        tweetsArray = data
        createAnnomationsAndLoadOnMap()
    }
    
    func showTweetDetailView(_ tweet: TWTRTweet) {
    
        let storyboard = UIStoryboard(name: "TweetDetails", bundle: nil)
        let tweetDetailVC: TweetDetailsViewController = storyboard.instantiateInitialViewController() as! TweetDetailsViewController
        tweetDetailVC.tweet = tweet
        
        self.parent?.navigationController?.pushViewController(tweetDetailVC, animated: true)

    }
    
    private func createAnnomationsAndLoadOnMap() {
        
        tweetsMapView?.annotations.forEach { annotation in
            guard annotation.title == "current location" else {
                tweetsMapView?.removeAnnotation(annotation)
                return
            }
        }
    
        var arrAnnotations = [MKPointAnnotation]()
        for tweet in tweetsArray {
            let annotation = TweetAnnotation()
            annotation.title = tweet.name
            annotation.tweetId = tweet.id
            
            if let arrCoordinates = tweet.place?.boundingBox?.coordinates?.first?.first {
                annotation.coordinate = CLLocationCoordinate2D(latitude: arrCoordinates[1], longitude: arrCoordinates[0])
            }
            
            annotation.subtitle = (tweet.place?.fullName ?? "Montreal") + ", " + (tweet.place?.country ?? "Canada")
            arrAnnotations.append(annotation)
        }
        tweetsMapView.addAnnotations(arrAnnotations)
    }
}

class TweetAnnotation: MKPointAnnotation {
    var tweetId: Int = 0
}


extension TweetsMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            annotationView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let annotation = view.annotation as? TweetAnnotation {
            presenter.fetchTweetDetails(annotation.tweetId)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circle = MKCircleRenderer(overlay: overlay)
        circle.strokeColor = .red
        circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
        circle.lineWidth = 1
        return circle
    }

}
