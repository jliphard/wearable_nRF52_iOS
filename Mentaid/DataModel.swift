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
 */

import Foundation
import CoreLocation

class DataModel {
    
    static let sharedInstance = DataModel()
    private init() { }
    
    private (set) var ticks:            UInt16 = 0
    private (set) var batteryPercent:   UInt8 = 0
    private (set) var batteryVoltage:   Double = 0.0
    private (set) var pressure:         Double = 0.0
    private (set) var temperature:      Double = 0.0
    private (set) var humidity:         UInt8 = 0
    private (set) var lightIntensity:   UInt16 = 0
    private (set) var accelX:           Double = 0.0
    private (set) var accelY:           Double = 0.0
    private (set) var accelZ:           Double = 0.0
    private (set) var storage:          UInt16 = 0
    private (set) var status:           UInt8 = 0

    private (set) var uploadToCloud:    Bool = false
    
    func setTicks(          x: UInt16 ) { self.ticks          = x }
    func setBatteryPercent( x: UInt8  ) { self.batteryPercent = x }
    func setBatteryVoltage( x: Double ) { self.batteryVoltage = x }
    func setPressure(       x: Double ) { self.pressure       = x }
    func setTemperature(    x: Double ) { self.temperature    = x }
    func setHumidity(       x: UInt8  ) { self.humidity       = x }
    func setLightIntensity( x: UInt16 ) { self.lightIntensity = x }
    func setAccelX(         x: Double ) { self.accelX         = x }
    func setAccelY(         x: Double ) { self.accelY         = x }
    func setAccelZ(         x: Double ) { self.accelZ         = x }
    func setStorage(        x: UInt16 ) { self.storage        = x }
    func setStatus(         x: UInt8  ) { self.status         = x }

    func setCloudUpload(    x: Bool )  { self.uploadToCloud   = x }

    
}
