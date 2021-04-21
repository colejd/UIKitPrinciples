//
//  AddressEntryViewController.swift
//  UIKitConcepts
//
//  Created by Jonathan Cole on 4/21/21.
//

import Anchorage
import UIKit

protocol AddressEntryViewControllerDelegate: class {
    func addressEntryViewController(_ addressEntryViewController: AddressEntryViewController, didSelectAddress address: String)
}

class AddressEntryViewController: UIViewController {

    weak var delegate: AddressEntryViewControllerDelegate? // This must be weak or you'll get memory leaks!

    var button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground

        // We're going to add a button that stands in for a more complicated view, where the user
        // might type in an address and select from a list.
        view.addSubview(button)
        button.setTitle("Supply a fake address", for: .normal)
        button.addTarget(self, action: #selector(fakeAddressButtonPressed), for: .primaryActionTriggered)

        // Put the button in the middle of the screen.
        button.centerAnchors == view.centerAnchors
        button.widthAnchor == view.widthAnchor // Specify the width anchor so the button text doesn't overflow if the screen is too small
    }
}

// MARK: - Button Handlers

extension AddressEntryViewController {
    @objc func fakeAddressButtonPressed() {
        delegate?.addressEntryViewController(self, didSelectAddress: "\(Int.random(in: 1...100)) Cool Street")
        // Get rid of this view controller. You could also make a close button that calls this.
        self.dismiss(animated: true)
    }
}
