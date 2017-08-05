/* Copyright (c) 2017, Stanford University
 * All rights reserved.
 *
 * The point of contact for the MENTAID wearables dev team is
 * Jan Liphardt (jan.liphardt@stanford.edu)
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of STANFORD UNIVERSITY nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY STANFORD UNIVERSITY "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL STANFORD UNIVERSITY OR ITS CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Parts of this software, primarily the basic BLE control code, were derived or
 * directly copied from the Nordic reference implementations available in their SDK
 * or in Nordic's reference iOS toolbox application.
 *
 * For those sections, the following license applies:
 *
 * Copyright (c) 2010 - 2017, Nordic Semiconductor ASA
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form, except as embedded into a Nordic
 *    Semiconductor ASA integrated circuit in a product or a software update for
 *    such product, must reproduce the above copyright notice, this list of
 *    conditions and the following disclaimer in the documentation and/or other
 *    materials provided with the distribution.
 *
 * 3. Neither the name of Nordic Semiconductor ASA nor the names of its
 *    contributors may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * 4. This software, with or without modification, must only be used with a
 *    Nordic Semiconductor ASA integrated circuit.
 *
 * 5. Any software provided in binary form under this license must not be reverse
 *    engineered, decompiled, modified and/or disassembled.
 *
 * THIS SOFTWARE IS PROVIDED BY NORDIC SEMICONDUCTOR ASA "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY, NONINFRINGEMENT, AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL NORDIC SEMICONDUCTOR ASA OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
 * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import CoreBluetooth

class MAViewController: BaseViewController, CBCentralManagerDelegate, CBPeripheralDelegate, ScannerDelegate {

    var bluetoothManager                : CBCentralManager?
    var isBluetoothOn                   : Bool?
    var isDeviceConnected               : Bool?
    var batteryServiceUUID              : CBUUID
    var batteryLevelCharacteristicUUID  : CBUUID
    var maServiceUUID                   : CBUUID
    var maMeasurementCharacteristicUUID : CBUUID
    var maLocationCharacteristicUUID    : CBUUID
    var peripheral                      : CBPeripheral?
    
    @IBOutlet weak var battery: UIButton!
    @IBOutlet weak var deviceName: UILabel!
    @IBOutlet weak var connectionButton: UIButton!
    @IBOutlet weak var uploadButton: UIButton!
    
    //Save to FLASH
    @IBOutlet var SaveToFLASH_Switch: UISwitch!
    @IBOutlet var SaveToFLASH_Switch_State: UILabel!
    
    //Stream via BLE
    @IBOutlet var LiveStream_Switch: UISwitch!
    @IBOutlet var LiveStream_Switch_State: UILabel!
    
    //Sampling On/Off
    @IBOutlet var Sampling_Switch: UISwitch!
    @IBOutlet var Sampling_Switch_State: UILabel!
    
    //MARK: - UIVIewController Actions
    @IBAction func connectionButtonTapped(_ sender: AnyObject) {
        if peripheral != nil
        {
            bluetoothManager?.cancelPeripheralConnection(peripheral!)
        }
    }
    
    //MARK: - UIViewController delegate
    required init?(coder aDecoder: NSCoder) {
        maServiceUUID                    = CBUUID(string: ServiceIdentifiers.maServiceUUIDString)
        maMeasurementCharacteristicUUID  = CBUUID(string: ServiceIdentifiers.maCharacteristicUUIDString)
        maLocationCharacteristicUUID     = CBUUID(string: ServiceIdentifiers.maSensorLocationCharacteristicUUIDString)
        batteryServiceUUID               = CBUUID(string: ServiceIdentifiers.batteryServiceUUIDString)
        batteryLevelCharacteristicUUID   = CBUUID(string: ServiceIdentifiers.batteryLevelCharacteristicUUIDString)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isBluetoothOn           = false
        isDeviceConnected       = false
        peripheral              = nil
    }
    
    @IBAction func Sampling_SwitchChanged(Sampling_Switch: UISwitch) {
        
        var parameter = NSInteger(0);
        
        if Sampling_Switch.isOn {
            Sampling_Switch_State.text = "ON"
            parameter = NSInteger(13);
        } else {
            Sampling_Switch_State.text = "OFF"
            parameter = NSInteger(12);
        }
        
        let command = NSData(bytes: &parameter, length: 1)
        
        if peripheral != nil {
            for aService : CBService in (peripheral?.services!)! {
                if aService.uuid.isEqual(maServiceUUID) {
                    for aCharacteristic : CBCharacteristic in aService.characteristics! {
                        if aCharacteristic.uuid.isEqual(maLocationCharacteristicUUID) {
                            print("Sent Sampling command to MENTAID")
                            peripheral?.writeValue(command as Data, for: aCharacteristic, type: CBCharacteristicWriteType.withResponse)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func FLASH_SwitchChanged(SaveToFLASH_Switch: UISwitch) {
        
        var parameter = NSInteger(0);
        
        if SaveToFLASH_Switch.isOn {
            SaveToFLASH_Switch_State.text = "ON"
            parameter = NSInteger(33);
        } else {
            SaveToFLASH_Switch_State.text = "OFF"
            parameter = NSInteger(32);
        }
        
        let command = NSData(bytes: &parameter, length: 1)
        
        if peripheral != nil {
            for aService : CBService in (peripheral?.services!)! {
                if aService.uuid.isEqual(maServiceUUID) {
                    for aCharacteristic : CBCharacteristic in aService.characteristics! {
                        if aCharacteristic.uuid.isEqual(maLocationCharacteristicUUID) {
                            print("Sent Save command to MENTAID")
                            peripheral?.writeValue(command as Data, for: aCharacteristic, type: CBCharacteristicWriteType.withResponse)
                        }
                    }
                }
            }
        }
    }

    
    @IBAction func LiveStream_SwitchChanged(LiveStream_Switch: UISwitch) {
        
        var parameter = NSInteger(0);
        
        if LiveStream_Switch.isOn {
            LiveStream_Switch_State.text = "ON"
            parameter = NSInteger(35);
        } else {
            LiveStream_Switch_State.text = "OFF"
            parameter = NSInteger(34);
        }
        
        let command = NSData(bytes: &parameter, length: 1)
        
        if peripheral != nil {
            for aService : CBService in (peripheral?.services!)! {
                if aService.uuid.isEqual(maServiceUUID) {
                    for aCharacteristic : CBCharacteristic in aService.characteristics! {
                        if aCharacteristic.uuid.isEqual(maLocationCharacteristicUUID) {
                            print("Sent LiveStream command to MENTAID")
                            peripheral?.writeValue(command as Data, for: aCharacteristic, type: CBCharacteristicWriteType.withResponse)
                        }
                    }
                }
            }
        }
    }

    @IBAction func UploadButtonTapped(_ sender: AnyObject) {
        
        if peripheral != nil
        {
            var parameter = NSInteger(42);
            
            let data = NSData(bytes: &parameter, length: 1)
            for aService : CBService in (peripheral?.services!)! {
                if aService.uuid.isEqual(maServiceUUID) {
                    for aCharacteristic : CBCharacteristic in aService.characteristics! {
                        if aCharacteristic.uuid.isEqual(maLocationCharacteristicUUID) {
                            print("Sent Upload command to MENTAID")
                            //peripheral?.readValue(for: aCharacteristic)
                            peripheral?.writeValue(data as Data, for: aCharacteristic, type: CBCharacteristicWriteType.withResponse)
                        }
                    }
                }
            }
        }
    }

    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    func clearUI()
    {
        deviceName.text = "DEFAULT MA";
        battery.setTitle("N/A", for: UIControlState())
        battery.tag = 0;
    }
    
    func centralManagerDidSelectPeripheral(withManager aManager: CBCentralManager, andPeripheral aPeripheral: CBPeripheral)
    {
        // We may not use more than one Central Manager instance. Let's just take the one returned from Scanner View Controller
        bluetoothManager = aManager;
        bluetoothManager!.delegate = self;
        
        // The sensor has been selected, connect to it
        peripheral = aPeripheral;
        aPeripheral.delegate = self;
        let options = NSDictionary(object: NSNumber(value: true as Bool), forKey: CBConnectPeripheralOptionNotifyOnNotificationKey as NSCopying)
        bluetoothManager!.connect(aPeripheral, options: options as? [String : AnyObject])
    }
    
    //MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        if central.state == .poweredOff {
            print("Bluetooth powered off")
        } else {
            print("Bluetooth powered on")
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral)
    {
        // Scanner uses other queue to send events. We must edit UI in the main queue
        
        DispatchQueue.main.async {
            //We are connected - YAY!
            self.deviceName.text = peripheral.name
            self.connectionButton.setTitle("DISCONNECT", for: UIControlState())
            self.SaveToFLASH_Switch.isEnabled = true
            self.Sampling_Switch.isEnabled = true
            self.LiveStream_Switch.isEnabled = true
        }
        
        if UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:))){
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .sound], categories: nil))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(MAViewController.appDidEnterBackgroundCallback), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MAViewController.appDidBecomeActiveCallback), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        // Peripheral has connected. Discover required services
        peripheral.discoverServices([maServiceUUID, batteryServiceUUID])
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        // Scanner uses other queue to send events. We must edit UI in the main queue
        DispatchQueue.main.async(execute: {
            AppUtilities.showAlert(title: "Error", andMessage: "Connecting to peripheral failed. Try again")
            self.connectionButton.setTitle("CONNECT", for: UIControlState())
            self.peripheral = nil
            self.clearUI()
            
        });
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        //DISCONNECT EVENT
        DispatchQueue.main.async(execute: {
            
            self.SaveToFLASH_Switch.isEnabled = false
            self.Sampling_Switch.isEnabled = false
            self.LiveStream_Switch.isEnabled = false
            
            self.connectionButton.setTitle("CONNECT", for: UIControlState())
            self.peripheral = nil;
            
            if AppUtilities.isApplicationInactive() {
                let name = peripheral.name ?? "Peripheral"
                AppUtilities.showBackgroundNotification(message: "\(name) is disconnected.")
            }
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        });
    }
    
    //MARK: - CBPeripheralDelegate
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    {
        guard error == nil else
        {
            print("An error occured while discovering services: \(error!.localizedDescription)")
            bluetoothManager!.cancelPeripheralConnection(peripheral)
            return
        }
        
        for aService : CBService in peripheral.services!
        {
            if aService.uuid.isEqual(maServiceUUID)
            {
                print("Mentaid Service found")
                peripheral.discoverCharacteristics(nil, for: aService)
            }
            else if aService.uuid.isEqual(batteryServiceUUID)
            {
                print("Battery service found")
                peripheral.discoverCharacteristics(nil, for: aService)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?)
    {
        guard error == nil else
        {
            print("Error occurred while discovering characteristic: \(error!.localizedDescription)")
            bluetoothManager!.cancelPeripheralConnection(peripheral)
            return
        }
        
        if service.uuid.isEqual(maServiceUUID)
        {
            for aCharacteristic : CBCharacteristic in service.characteristics!
            {
                if aCharacteristic.uuid.isEqual(maMeasurementCharacteristicUUID)
                {
                    print("Mentaid measurement characteristic found")
                    peripheral.setNotifyValue(true, for: aCharacteristic)
                }
                else if aCharacteristic.uuid.isEqual(maLocationCharacteristicUUID)
                {
                    print("Mentaid sensor location characteristic found")
                    peripheral.readValue(for: aCharacteristic)
                }
            }
        }
        else if service.uuid.isEqual(batteryServiceUUID)
        {
            for aCharacteristic : CBCharacteristic in service.characteristics!
            {
                if aCharacteristic.uuid.isEqual(batteryLevelCharacteristicUUID)
                {
                    print("Battery level characteristic found")
                    peripheral.readValue(for: aCharacteristic)
                }
            }
        }
    }
    
    let mySpecialNotificationKey = "com.Mentaid.specialNotificationKey"
    
    func notify() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: mySpecialNotificationKey), object: self)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
    {
        
        guard error == nil else
        {
            print("Error occurred while updating characteristic value: \(error!.localizedDescription)")
            return
        }
        
        DispatchQueue.main.async
        {
            if characteristic.uuid.isEqual(self.maMeasurementCharacteristicUUID)
            {
                //and now we need to move this into the data model
                self.decodeAndShareValues(withData: characteristic.value!)
                
                //and now we need to notify everyone
                self.notify()
            }
            else if characteristic.uuid.isEqual(self.maLocationCharacteristicUUID)
            {
                //self.decodeMALocation(withData: characteristic.value!)
                //we can use this to keep track of recent commands
                //TODO TODO TODO
            }
            else if characteristic.uuid.isEqual(self.batteryLevelCharacteristicUUID)
            {
                let data = characteristic.value as NSData?
                let array : UnsafePointer<UInt8> = (data?.bytes)!.assumingMemoryBound(to: UInt8.self)
                let batteryLevel : UInt8 = array[0]
                let text = "\(batteryLevel)%"
                self.battery.setTitle(text, for: UIControlState.disabled)
                
                DataModel.sharedInstance.setBattery(x: batteryLevel)
                self.notify()

                //not sure what this is doing...
                if self.battery.tag == 0
                {
                    if characteristic.properties.rawValue & CBCharacteristicProperties.notify.rawValue > 0
                    {
                       self.battery.tag = 1 // Mark that we have enabled notifications
                       peripheral.setNotifyValue(true, for: characteristic)
                    }
                }
            }
        }
    }
    
    //MARK: - UIApplicationDelegate callbacks
    func appDidEnterBackgroundCallback()
    {
        let name = peripheral?.name ?? "peripheral"
        AppUtilities.showBackgroundNotification(message: "You are still connected to \(name). It will also collect data in the background.")
    }
    
    func appDidBecomeActiveCallback()
    {
        UIApplication.shared.cancelAllLocalNotifications()
    }
    
    //MARK: - Segue management
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        // The 'scan' seque will be performed only if connectedPeripheral == nil (if we are not connected already).
        return identifier != "scan" || peripheral == nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "scan" {
            // Set this contoller as scanner delegate
            let nc                = segue.destination as! UINavigationController
            let controller        = nc.childViewControllerForStatusBarHidden as! ScannerViewController
            controller.filterUUID = maServiceUUID
            controller.delegate   = self
        }
    }

    func decodeAndShareValues(withData data: Data)
    {
        
        let count = data.count / MemoryLayout<UInt8>.size
        
        var array = [UInt8](repeating: 0, count: count)
        
        (data as NSData).getBytes(&array, length:count * MemoryLayout<UInt8>.size)
        
        //if ((array[0] & 0x01) == 0)
        //{
            //this bitpacking flag no longer used
        //}
        //else
        //{
            //array zero has flag data in it....
            
            var uInt16Value: UInt16 = 0
            var Int16Value:   Int16 = 0
            
            DataModel.sharedInstance.setTicks(x: UInt16(array[2]) << 8 | UInt16(array[1]))
            
            //print("Time: %d", UInt16(array[2]) << 8 | UInt16(array[1]));
            
            DataModel.sharedInstance.setBattery2(x: array[3]) //battery from 0 to about 110
            
            DataModel.sharedInstance.setPressure(x: ((Double(array[4]) + 10000.0 ) / 10.0))
            
            DataModel.sharedInstance.setTemperature(x: ((Double(array[5]) +   200.0 ) / 10.0));
            
            DataModel.sharedInstance.setHumidity(x: array[6]);

            //light intensity - this is UINT 16 bits
            uInt16Value = UInt16(array[8]) << 8 | UInt16(array[7])
            DataModel.sharedInstance.setLightIntensity(x: UInt16(Double(uInt16Value) / 655.0) );
            
            //Ax
            Int16Value = Int16(array[10]) << 8 | Int16(array[9])
            //arrayRes[6] = (Double(Int16Value) / 40.0) + 50.0
            DataModel.sharedInstance.setAccelX(x: (Double(Int16Value) / 40.0) + 50.0 );
            
            //Ay
            Int16Value = Int16(array[12]) << 8 | Int16(array[11])
            //rrayRes[7] = (Double(Int16Value) / 40.0) + 50.0
            DataModel.sharedInstance.setAccelY(x: (Double(Int16Value) / 40.0) + 50.0 );
            
            //Az
            Int16Value = Int16(array[14]) << 8 | Int16(array[13])
            DataModel.sharedInstance.setAccelZ(x: (Double(Int16Value) / 40.0) + 50.0 );
            
            //Storage
            DataModel.sharedInstance.setStorage(x: UInt16(array[16]) << 8 | UInt16(array[15]) );

        //}
        
    }
    
    func decodeMALocation(withData data:Data) -> String {
        
        let location = (data as NSData).bytes.bindMemory(to: UInt16.self, capacity: data.count)
        
        switch (location[0])
        {
            case 0:
                return "Other"
            case 1:
                return "Chest"
            case 2:
                return "Wrist"
            case 3:
                return "Finger"
            case 4:
                return "Hand";
            case 5:
                return "Ear"
            case 6:
                return "Foot"
            default:
                return "Invalid";
        }
    }
}
