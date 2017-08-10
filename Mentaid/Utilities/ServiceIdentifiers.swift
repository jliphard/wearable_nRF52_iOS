
import Foundation

class ServiceIdentifiers: NSObject {
    
    //Mentaid Identifiers
    static let maServiceUUIDString                          = "0000180D-0000-1000-8000-00805F9B34FB"
    static let maDataCharacteristicUUIDString               = "00002A4A-0000-1000-8000-00805F9B34FB"
    static let maCommandCharacteristicUUIDString            = "00002A4B-0000-1000-8000-00805F9B34FB"
    static let maStatusCharacteristicUUIDString             = "00002A4C-0000-1000-8000-00805F9B34FB"
    
    //#define BLE_UUID_MENTAID_MEASUREMENT_CHAR  0x2A4A
    //#define BLE_UUID_MENTAID_COMMAND_CHAR      0x2A4B
    //#define BLE_UUID_MENTAID_STATUS_CHAR       0x2A4C
    //#define BLE_UUID_MENTAID_STATUS_NOT_CHAR   0x2A4D
    
    //Battery Identifiers
    static let batteryServiceUUIDString                            = "0000180F-0000-1000-8000-00805F9B34FB"
    static let batteryLevelCharacteristicUUIDString                = "00002A19-0000-1000-8000-00805F9B34FB"
    
}
