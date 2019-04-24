//
//  AppDelegate.swift
//  MBPSingleStroke
//
//  Created by Alexander Jenke on 24.04.19.
//  Copyright © 2019 Alexander Jenke. All rights reserved.
//

import Cocoa
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    var eventlistener: Any? = nil
    var strokeTimeDict: [String: Double] = [:]
    let delKeyCode: UInt16 = 51

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // create menubar icon & menu with exit row
        if let button = statusItem.button {button.image = NSImage(named:NSImage.Name("StatusBarIcon"))}
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Quit SingleStroke", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
        // global monitor for keydown events
        eventlistener = NSEvent.addGlobalMonitorForEvents(matching: NSEvent.EventTypeMask.keyDown, handler: keystrokeHandler)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        NSEvent.removeMonitor(eventlistener!)
    }
    
    // handling the detecteed keystrokes
    @objc func keystrokeHandler(event: NSEvent) {
        if !event.isARepeat &&
            event.keyCode < delKeyCode && // only monitor keys that produces a char when pressed
            (event.timestamp - (strokeTimeDict[event.characters!] ?? 0) < 0.1) { // check for errounous double keystroke by time between keystrokes
            
            // simlulate backspace press
            let keyDownEvent = CGEvent(keyboardEventSource: nil, virtualKey: delKeyCode, keyDown: true)
            let keyUpEvent = CGEvent(keyboardEventSource: nil, virtualKey: delKeyCode, keyDown: false)
            
            keyDownEvent?.post(tap: CGEventTapLocation.cghidEventTap)
            keyUpEvent?.post(tap: CGEventTapLocation.cghidEventTap)
            
            // inform user
            NSSound(named: "Purr")?.play()

        }
        // update the time the key was last pressed
        strokeTimeDict[event.characters!] = event.timestamp
    }
}
