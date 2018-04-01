# SpritzSwift
Spritz reading framework based on AFSpritz.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/VChoubard/SpritzSwift.svg?branch=master)](https://travis-ci.org/VChoubard/SpritzSwift)

![alt text](https://media.giphy.com/media/18Tb56ycWSOg2cDGU2/giphy.gif "Example")

## Installation

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate SnapKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "VChoubard/SpritzSwift" ~> 1.0.0
```

Run `carthage update` to build the framework.
In your Xcode project add `SpritzSwift.framework` into `Embedded Binaries`

### Manually

Just import those files to your project:

    SSView.swift
    SSLabel.swift
    SSViewPresentationDelegate.swift
    SSManager.swift
    SSWord.swift

---

## Usage

Initialise ```SSManager``` assigning a text and a number of words per minute, that will determine the speed of the reading. Theorically, there's no limit, but the more confortable speed is 200-250 words per minute. However, Spritz is made for let you read more than 500 words per minute.

    SSManager(withText: "Welcome to SwiftSpritz! Spritz is a brand new revolutionary reading method that will help you to improve your number of words per minute. Take a look at SwiftSpritz!", andWordPerMinute: 250)

Then, call the block that will start the reading and sending you a word to show and the current status of the manager. Use the SSView for a custom Spritz view :)

    ssView = SSView(frame: CGRect(x: 20, y: 20, width: 200, height: 40 ), delegate: self)!
    ssView.backgroundColor = .clear
    self.view.addSubview(ssView!)

    manager.startReading { (word, finished) in
        if !finished {
            self.ssView?.updateWord(word!)
        }
    }


### Checking the status

    enum Status {
        case stopped
        case reading
        case notStarted
        case finished
    }

SwiftSpritz has the feature of checking in each moment the status of the reading using ```manager.status```.

Example:

    if manager.status == .reading {

        // The current status is reading

    } else if manager.status == .notStarted {

        // The current status is not started yet

    }  else if manager.status == .stopped {

        // The current status is stopped, so it can be resumed

    } else if manager.status == .finished {

        // The current status is finished

    }

### Pausing and resuming

You can pause and resume your reading just calling these two methods:

    manager.pauseReading()

    manager.resumeReading()


###  Presentation

You can implement the  SSViewPresentationDelegate and pass it to the SSView constructor to customize the visual of the SSView

    @objc
    protocol SSViewPresentationDelegate {

        // Determine the offset of the marker position inside the view.
        @objc optional func getMarkerOffset() -> CGFloat

        // Determines the color of the letter you're supposed to be focused on.
        @objc optional func getMarkerColor() -> UIColor

        // Determines the color of the lines around the word.
        @objc optional func getLinesColor() -> UIColor

        // Determines the color of the text.
        @objc optional func getTextColor() -> UIColor

        // Determines the font of the text.
        @objc optional func getTextFont() -> UIFont

    }

## Author

Made by  Vincent Choubard. If you have any question, feel free to drop me a line at [vincentchoubard@gmail.com](mailto:vincentchoubard@gmail.com)
