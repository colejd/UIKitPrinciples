//
//  BasicViewController.swift
//  UIKitConcepts
//
//  Created by Jonathan Cole on 4/21/21.
//

import Anchorage
import UIKit

class BasicViewController: UIViewController {

    let topView = UIView()
    let bottomView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        /**
         When you aren't using Storyboards, you need to specify the layout of everything you put on-screen.
         There are a few ways to do this, but we're going to use Auto Layout.
         When using Auto Layout, you describe the position and size of Views using constraints.

         An important detail is that you *must* add your views to the "view hierarchy" before
         you set up constraints, or you'll get a crash. For example, if you make a view and
         you want to make its width the same as another view's width, you need the new view
         to be a sibling or a descendant of the other view.

         To that end, I like to have two phases for setting up views.
         `setupViews()` is for actually making the views, configuring them,
         and putting them in the hierarchy. `setupConstraints()` is for setting
         up Auto Layout constraints afterwards.
         */
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        /**
         Every ViewController has an internal View called `view` that it manages.
         Generally, you're going to want to put everything you make into this view.
         `self.view.addSubview(someOtherView)`
         */

        view.backgroundColor = .systemBackground

        view.addSubview(topView)
        topView.backgroundColor = .red
        view.addSubview(bottomView)
        bottomView.backgroundColor = .blue

        // You can use this to set the properties of the navigation bar
        // if the ViewController belongs to a navigation controller.
        navigationItem.title = "BasicViewController"

    }

    private func setupConstraints() {
        /**
         To position a view with Auto Layout, you need to set up a system of constraints.
         These constraints should sufficiently describe the position of the view, as well as its size.
         - Note that some views have an "intrinsic size", which means you don't need to describe its
           size for it to be positioned. For example, text doesn't need to be manually sized.

         Before we begin, note that in `createViews()`, I made topView and bottomView children of the
         ViewController's `self.view` object. This `self.view` fills all available space.

         For our example, we'll make the top view take up the top half of the screen vertically, and
         the bottom view will fill up the bottom half.

         Let's break down what this means in terms of constraints, focusing only on the topView for now:
         - topView's origin (the top-left corner) is located at the top of `self.view`
         - topView's origin is located at the left of `self.view`
         - topView's width is the same as the screen width
         - topView's height is 50% of the height of the screen

         I'll go into a few ways to do this. Try uncommenting one of METHOD 1, METHOD 2, or METHOD 3 to see their effects (or rather, that they all do the same thing!)
         */

        /// -------------------------------------------------------------------

        /// To set up constraints, you would write them like this:
        // METHOD 1
        /*
        topView.translatesAutoresizingMaskIntoConstraints = false // You need to do this on anything you use Auto Layout on!
        let constraints = [
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.widthAnchor.constraint(equalTo: view.widthAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(constraints)
        */

        /// -------------------------------------------------------------------

        /// There's a lot you can do with constraints. I recommend reading up here: https://www.avanderlee.com/swift/auto-layout-programmatically/

        /// I personally like using Anchorage, which gives you a nicer syntax
        /// and automatically sets translatesAutoresizingMaskIntoConstraints so
        /// you don't have to. Here's the above constraints written with Anchorage:
        // METHOD 2
        /*
        topView.topAnchor == view.topAnchor
        topView.leadingAnchor == view.leadingAnchor
        topView.widthAnchor == view.widthAnchor
        topView.heightAnchor == view.heightAnchor * 0.5
        */

        /// -------------------------------------------------------------------

        /// This could be written a bit better, though:

        // METHOD 3
        // Set Y position
        topView.topAnchor == view.topAnchor
        // "Pin" the left and right edges to those of `self.view`.
        // This implicitly sets width and X position
        topView.horizontalAnchors == view.horizontalAnchors
        // "Pin" the bottom to the halfway point of `self.view` vertically.
        topView.bottomAnchor == view.centerYAnchor

        /// We don't ever set the width and height, but because
        /// we're "pinning" the edges to something that has a defined
        /// width and height, those are implicitly calculated.

        /**
         The thing to take away here is that width and height can be set in 3 ways:
         1. Automatically by the content of the view (intrinsic size)
         2. Explicitly with constraints that directly set width and height
         3. By "pinning" edges to another view that has a known width and height, which is what we just did.
         */

        /// -------------------------------------------------------------------

        /**
         Let's set up the bottomView constraints in the same way:
         */
        // This means the top of bottomView will start at the bottom of topView.
        bottomView.topAnchor == topView.bottomAnchor
        bottomView.horizontalAnchors == view.horizontalAnchors
        bottomView.bottomAnchor == view.bottomAnchor
    }
}
