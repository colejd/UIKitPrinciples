//
//  MapViewController.swift
//  UIKitConcepts
//
//  Created by Jonathan Cole on 4/21/21.
//

import Anchorage
import UIKit

import MapKit

class MapViewController: UIViewController {

    let topView = UIView()
    let bottomView = UIView()

    let mapView = MKMapView()
    let vemiCoordinates = CLLocationCoordinate2D(latitude: 44.897979, longitude: -68.671126)

    let tripPlanningView = TripPlanningView()

    var pickupLocation: String? {
        didSet {
            tripPlanningView.pickupLocation = pickupLocation
        }
    }
    var dropoffLocation: String? {
        didSet {
            tripPlanningView.dropoffLocation = dropoffLocation
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()

        // Zoom in on VEMI
        let mapRegion = MKCoordinateRegion(center: vemiCoordinates, latitudinalMeters: 100, longitudinalMeters: 100)
        mapView.setRegion(mapRegion, animated: true)
    }

    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "MapViewController"

        view.addSubview(topView)
        topView.backgroundColor = .red

        // Make the map view a child of topView.
        // You could just replace topView with mapView
        // everywhere in this example, but I'm keeping it
        // for consistency with BasicViewController.
        topView.addSubview(mapView)

        view.addSubview(bottomView)
        bottomView.backgroundColor = .blue
        // Make tripPlanningView a child of bottomView.
        bottomView.addSubview(tripPlanningView)

        // Start receiving events from tripPlanningView
        tripPlanningView.delegate = self
    }

    private func setupConstraints() {
        // Set up the top view
        topView.topAnchor == view.safeAreaLayoutGuide.topAnchor // Use "safe top anchor" so we don't go under the nav bar
        topView.horizontalAnchors == view.horizontalAnchors
        topView.bottomAnchor == view.centerYAnchor

        // Make the map view fill topView
        mapView.edgeAnchors == topView.edgeAnchors

        // Set up the bottom view
        bottomView.topAnchor == topView.bottomAnchor
        bottomView.horizontalAnchors == view.horizontalAnchors
        bottomView.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor // Use "safe bottom anchor" so we don't go under the Home Bar on iPhone X-style devices

        // Make the TripPlanningView fill bottomView
        tripPlanningView.edgeAnchors == bottomView.edgeAnchors
    }
}


// MARK: - TripPlanningViewDelegate

/**
 Generally, I like to keep conformances to delegates in their own extension.
 That way, all the methods you have to implement are grouped in one place.
 */
extension MapViewController: TripPlanningViewDelegate {
    func tripPlanningViewDidPressPickupButton(_ tripPlanningView: TripPlanningView) {
        print("Pickup button was pressed!")
        // You could take this opportunity to present a new view controller
        // that lets the user select their location, then set `self.pickupLocation`.
    }

    func tripPlanningViewDidPressDropoffButton(_ tripPlanningView: TripPlanningView) {
        print("Dropoff button was pressed!")
        // Let's do an example view controller that handles address selection.
        let addressVC = AddressEntryViewController()
        // Sign up to get events from the AddressEntryViewController
        addressVC.delegate = self

        // METHOD 1: Use this ViewController to present the new one
        addressVC.modalPresentationStyle = .automatic // Try playing with this value to use different presentation styles.
        present(addressVC, animated: true)

        // METHOD 2: You could also push this on the nav stack instead!
//        self.navigationController?.pushViewController(addressVC, animated: true)
        // This one won't auto-dismiss when you push the "supply a fake address" button.
        // You'll need to call self.navigationController?.popViewController() somewhere.
        // maybe in `addressEntryViewController(didSelectAddress:)` below?
    }
}

// MARK: - AddressEntryViewControllerDelegate

extension MapViewController: AddressEntryViewControllerDelegate {
    func addressEntryViewController(_ addressEntryViewController: AddressEntryViewController, didSelectAddress address: String) {
        self.dropoffLocation = address
    }
}
