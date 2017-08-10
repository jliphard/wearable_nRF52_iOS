
import UIKit
import SwiftyBeaver
let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //let console = ConsoleDestination()  // log to Xcode Console
        let file    = FileDestination()       // log to default swiftybeaver.log file - where is this file??????
        let cloud   = SBPlatformDestination(appID: Keys.sharedInstance.appID, appSecret: Keys.sharedInstance.appSecret, encryptionKey: Keys.sharedInstance.encryptionKey)

        cloud.analyticsUserName = "Tester1"
        cloud.showNSLog         = false
        
        //log.addDestination(console)
        log.addDestination(file)
        log.addDestination(cloud)
        
        log.info("Log 1")   // prio 3, INFO in green
        
 /*
 // log with different importance
 log.verbose("not so important")  // prio 1, VERBOSE in silver
 log.debug("something to debug")  // prio 2, DEBUG in blue
 log.info("a nice information")   // prio 3, INFO in green
 log.warning("oh no, that won’t be good")  // prio 4, WARNING in yellow
 log.error("ouch, an error did occur!")  // prio 5, ERROR in red
 
 // log strings, ints, dates, etc.
 log.verbose(123)
 log.info(-123.45678)
 log.warning(NSDate())
 log.error(["I", "like", "logs!"])
 log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])
 */
        
        return true
    }

}
