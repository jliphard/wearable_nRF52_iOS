//
//  NORAppUtilities.swift
//  nRF Toolbox
//
//  Created by Mostafa Berg on 18/05/16.
//  Copyright © 2016 Nordic Semiconductor. All rights reserved.
//

import UIKit

enum ServiceIds : UInt8 {
    case ma = 0
}

class AppUtilities: NSObject {

    static let mentaidHelpText = "The Mentaid profile allows you to connect and read data from your Mentaid device. It shows TODO, location of the sensor and displays the historical data on a graph."
    
    static let helpText: [ServiceIds: String] = [.ma: mentaidHelpText]

    static func showAlert(title aTitle : String, andMessage aMessage: String){
        let alertView = UIAlertView(title: aTitle, message: aMessage, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }

    static func showBackgroundNotification(message aMessage : String){
        let localNotification = UILocalNotification()
        localNotification.alertAction   = "Show"
        localNotification.alertBody     = aMessage
        localNotification.hasAction     = false
        localNotification.fireDate      = Date(timeIntervalSinceNow: 1)
        localNotification.timeZone      = TimeZone.current
        localNotification.soundName     = UILocalNotificationDefaultSoundName
    }
    
    static func isApplicationInactive() -> Bool {
        let appState = UIApplication.shared.applicationState
        return appState != UIApplicationState.active
    }
    
    static func getHelpTextForService(service aServiceId: ServiceIds) -> String {
        return helpText[aServiceId]!
    }
}
