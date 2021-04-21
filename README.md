#  UIKit Concepts

## How I Built This Project

* Create a new project with UIKit:
![Project setup step 1](/readme/ProjectSetup1.png)
![Project setup step 2](/readme/ProjectSetup2.png)
* Follow guide [here](https://sarunw.com/posts/how-to-create-new-xcode-project-without-storyboard/#xcode-11) to remove the main storyboard and start with a view controller directly.


## Where to Start

Start in [`SceneDelegate.swift`](/UIKitConcepts/Application/SceneDelegate.swift).


## General Principles

### ViewControllers are smart, Views are dumb

In general, Views should only be containers for UI elements. Views should not be directly modifying application state; rather, have them tell ViewControllers to do that instead. A view's job is simply to show data and handle very basic interactions.

Accordingly, ViewControllers should be responsible for updating views and making higher-level things happen.

This design principle can be found in Apple's own `UIButton` class, for example. If you want a `UIButton` to do something, you want to handle the button press in the ViewController that holds it. All `UIButton` does is show a title and indicate that it's been pressed.


### ViewControllers should be creatable in a vacuum

A single ViewController should be thought of as a self-contained system.

In practical terms, this means that you should be able to create any ViewController at any time, without needing any external state to be configured a certain way first.
This makes testing much easier, but more importantly, it also forces you to build in a way that is ultimately better in the long term.

