//
//  AppDelegate.swift
//  Screenbrightness
//
//  Created by Jaap Mengers on 01-03-17.
//  Copyright © 2017 Jaap Mengers. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application


    let _ = Timer.scheduledTimer(
      timeInterval: 0.1, target: self, selector: #selector(getBrightnessLevel),
      userInfo: nil, repeats: true)

  }


  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


  @objc private func getBrightnessLevel() {
    var iterator: io_iterator_t = 0

    let result = IOServiceGetMatchingServices(kIOMasterPortDefault,
                                              IOServiceMatching("IODisplayConnect"),
                                              &iterator)

    if result == kIOReturnSuccess {
      var service: io_object_t = 1

      var value: Float = 0

      while(service != 0) {

        service = IOIteratorNext(iterator)

        IODisplayGetFloatParameter(service, 0, kIODisplayBrightnessKey as CFString!, &value)

        let url = URL(string: "http://localhost:4242/?q=\(value)")

        URLSession.shared.dataTask(with: url!) { data, response, error in

        }.resume()

        IOObjectRelease(service)
      }
    }
  }


}

