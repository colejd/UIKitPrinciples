//
//  TripPlanningView.swift
//  UIKitConcepts
//
//  Created by Jonathan Cole on 4/21/21.
//

import Anchorage
import UIKit

protocol TripPlanningViewDelegate: class {
    func tripPlanningViewDidPressPickupButton(_ tripPlanningView: TripPlanningView)
    func tripPlanningViewDidPressDropoffButton(_ tripPlanningView: TripPlanningView)
}

class TripPlanningView: UIView {

    weak var delegate: TripPlanningViewDelegate? // Always use `weak` for protocols or you'll get memory leaks.

    private var pickupButton = UIButton(type: .system)
    private var dropoffButton = UIButton(type: .system)

    var pickupLocation: String? = nil {
        didSet {
            pickupButton.setTitle(pickupLocation ?? "Set Pickup Location", for: .normal)
        }
    }
    var dropoffLocation: String? = nil{
        didSet {
            dropoffButton.setTitle(dropoffLocation ?? "Set Dropoff Location", for: .normal)
        }
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground

        addSubview(pickupButton)
        pickupButton.topAnchor == topAnchor + 20
        pickupButton.horizontalAnchors == horizontalAnchors

        addSubview(dropoffButton)
        dropoffButton.topAnchor == pickupButton.bottomAnchor + 10
        dropoffButton.horizontalAnchors == horizontalAnchors

        // Set up handlers for button presses
        pickupButton.addTarget(self, action: #selector(pickupButtonPressed), for: .primaryActionTriggered)
        dropoffButton.addTarget(self, action: #selector(dropoffButtonPressed), for: .primaryActionTriggered)

        pickupButton.setTitle(pickupLocation ?? "Set Pickup Location", for: .normal)
        dropoffButton.setTitle(dropoffLocation ?? "Set Dropoff Location", for: .normal)
    }

    // This is required when you make a custom `init()` on a UIView subclass.
    // You can just leave it blank.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Button Handlers

extension TripPlanningView {
    /*
     To use a method as a selector, it must be tagged as `@objc`.
     We're just going to use these methods to call the corresponding
     `TripPlanningViewDelegate` methods.
     */

    @objc private func pickupButtonPressed() {
        delegate?.tripPlanningViewDidPressPickupButton(self)
    }

    @objc private func dropoffButtonPressed() {
        delegate?.tripPlanningViewDidPressDropoffButton(self)
    }
}
