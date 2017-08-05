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
 * Parts of this software, namely the CPTGraphHostingView code, were derived or
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
import CorePlot

/*
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}
*/

let mySpecialNotificationKey = "com.Mentaid.specialNotificationKey"

class DebugViewController: UIViewController, CPTPlotDataSource, CPTPlotSpaceDelegate {
    
    var ValuesCH1  : NSMutableArray?
    var ValuesCH2  : NSMutableArray?
    var ValuesCH3  : NSMutableArray?
    var ValuesCH4  : NSMutableArray?
    var ValuesCH5  : NSMutableArray?
    var ValuesCH6  : NSMutableArray?
    var ValuesCH7  : NSMutableArray?
    var ValuesCH8  : NSMutableArray?
    var ValuesCH9  : NSMutableArray?
    
    var xValues : NSMutableArray?
    
    var plotXMaxRange : Int?
    var plotXMinRange : Int?
    var plotYMaxRange : Int?
    var plotYMinRange : Int?
    var plotXInterval : Int?
    var plotYInterval : Int?
    
    var linePlot1 : CPTScatterPlot?
    var linePlot2 : CPTScatterPlot?
    var linePlot3 : CPTScatterPlot?
    var linePlot4 : CPTScatterPlot?
    var linePlot5 : CPTScatterPlot?
    var linePlot6 : CPTScatterPlot?
    var linePlot7 : CPTScatterPlot?
    var linePlot8 : CPTScatterPlot?
    var linePlot9 : CPTScatterPlot?
    
    var graph : CPTGraph?
    
    @IBOutlet weak var battery: UIButton!

    @IBOutlet weak var S1C1:  UILabel!
    @IBOutlet weak var S1C2:  UILabel!
    @IBOutlet weak var S1C3:  UILabel!
    @IBOutlet weak var S1C4:  UILabel!
    @IBOutlet weak var S1C5:  UILabel!
    @IBOutlet weak var S1C6:  UILabel!
    @IBOutlet weak var S1C7:  UILabel!
    @IBOutlet weak var S1C8:  UILabel!
    @IBOutlet weak var S1C9:  UILabel!
    @IBOutlet weak var S1C10: UILabel!

    
    @IBOutlet weak var graphView: CPTGraphHostingView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(DebugViewController.actOnSpecialNotification), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
     
        xValues   = NSMutableArray()
     
        ValuesCH1 = NSMutableArray()
        ValuesCH2 = NSMutableArray()
        ValuesCH3 = NSMutableArray()
        ValuesCH4 = NSMutableArray()
        ValuesCH5 = NSMutableArray()
        ValuesCH6 = NSMutableArray()
        ValuesCH7 = NSMutableArray()
        ValuesCH8 = NSMutableArray()
        ValuesCH9 = NSMutableArray()
     
        initLinePlot()
    }
    
    func initLinePlot() {
        
        //Initialize and display Graph (x and y axis lines)
        graph = CPTXYGraph(frame: graphView.bounds)
        self.graphView.hostedGraph = self.graph;
        
        //apply styling to Graph
        graph?.apply(CPTTheme(named: CPTThemeName.plainWhiteTheme))
        
        //set graph backgound area transparent
        graph?.fill = CPTFill(color: CPTColor.clear())
        graph?.plotAreaFrame?.fill = CPTFill(color: CPTColor.clear())
        //graph?.plotAreaFrame?.fill = CPTFill(color: CPTColor.clear())
        
        //This removes top and right lines of graph
        graph?.plotAreaFrame?.borderLineStyle = CPTLineStyle(style: nil)
        //This shows x and y axis labels from 0 to 1
        graph?.plotAreaFrame?.masksToBorder = false
        
        // set padding for graph from Left and Bottom
        graph?.paddingBottom    = 30;
        graph?.paddingLeft      = 50;
        graph?.paddingRight     = 0;
        graph?.paddingTop       = 0;
        
        //Define x and y axis range
        // x-axis from 0 to 100
        // y-axis from 0 to 300
        let plotSpace = graph?.defaultPlotSpace
        plotSpace?.allowsUserInteraction = true
        plotSpace?.delegate = self;
        self.resetPlotRange()
        
        let axisSet = graph?.axisSet as! CPTXYAxisSet;
        
        let axisLabelFormatter = NumberFormatter()
        axisLabelFormatter.generatesDecimalNumbers = false
        axisLabelFormatter.numberStyle = NumberFormatter.Style.decimal
        
        //Define x-axis properties
        //x-axis intermediate interval 2
        let xAxis = axisSet.xAxis
        xAxis?.majorIntervalLength = plotXInterval as NSNumber?
        xAxis?.minorTicksPerInterval = 4;
        xAxis?.minorTickLength = 5;
        xAxis?.majorTickLength = 7;
        xAxis?.title = "Time (s)"
        xAxis?.titleOffset = 25;
        xAxis?.labelFormatter = axisLabelFormatter
        
        //Define y-axis properties
        let yAxis = axisSet.yAxis
        yAxis?.majorIntervalLength = plotYInterval as NSNumber?
        yAxis?.minorTicksPerInterval = 4
        yAxis?.minorTickLength = 5
        yAxis?.majorTickLength = 7
        
        linePlot1 = CPTScatterPlot()
        linePlot2 = CPTScatterPlot()
        linePlot3 = CPTScatterPlot()
        linePlot4 = CPTScatterPlot()
        linePlot5 = CPTScatterPlot()
        linePlot6 = CPTScatterPlot()
        linePlot7 = CPTScatterPlot()
        linePlot8 = CPTScatterPlot()
        linePlot9 = CPTScatterPlot()
        
        linePlot1?.dataSource = self
        linePlot2?.dataSource = self
        linePlot3?.dataSource = self
        linePlot4?.dataSource = self
        linePlot5?.dataSource = self
        linePlot6?.dataSource = self
        linePlot7?.dataSource = self
        linePlot8?.dataSource = self
        linePlot9?.dataSource = self
        
        linePlot1?.identifier = NSString.init(string: "PlotTime")
        
        linePlot2?.identifier = NSString.init(string: "PlotBattery")
        
        linePlot3?.identifier = NSString.init(string: "PlotPressure")
        linePlot4?.identifier = NSString.init(string: "PlotTemperature")
        linePlot5?.identifier = NSString.init(string: "PlotHumidity")
        
        linePlot6?.identifier = NSString.init(string: "PlotIntensity")
        
        linePlot7?.identifier = NSString.init(string: "PlotAx")
        linePlot8?.identifier = NSString.init(string: "PlotAy")
        linePlot9?.identifier = NSString.init(string: "PlotAz")
        
        graph?.add(linePlot1!, to: plotSpace)
        graph?.add(linePlot2!, to: plotSpace)
        graph?.add(linePlot3!, to: plotSpace)
        graph?.add(linePlot4!, to: plotSpace)
        graph?.add(linePlot5!, to: plotSpace)
        graph?.add(linePlot6!, to: plotSpace)
        graph?.add(linePlot7!, to: plotSpace)
        graph?.add(linePlot8!, to: plotSpace)
        graph?.add(linePlot9!, to: plotSpace)
        
        //set line plot style
        let lineStyle1 = linePlot1?.dataLineStyle!.mutableCopy() as! CPTMutableLineStyle
        lineStyle1.lineWidth = 2
        lineStyle1.lineColor = CPTColor.black()
        linePlot1!.dataLineStyle = lineStyle1;
        
        let symbolLineStyle1 = CPTMutableLineStyle(style: lineStyle1)
        symbolLineStyle1.lineColor = CPTColor.black()
        
        let symbol1 = CPTPlotSymbol.ellipse()
        symbol1.fill = CPTFill(color: CPTColor.black())
        symbol1.lineStyle = symbolLineStyle1
        symbol1.size = CGSize(width: 3.0, height: 3.0)
        linePlot1?.plotSymbol = symbol1;
        
        //set line plot style
        let lineStyle2 = linePlot2?.dataLineStyle!.mutableCopy() as! CPTMutableLineStyle
        lineStyle2.lineWidth = 2
        lineStyle2.lineColor = CPTColor.red()
        linePlot2!.dataLineStyle = lineStyle2;
        
        let symbolLineStyle2 = CPTMutableLineStyle(style: lineStyle2)
        symbolLineStyle2.lineColor = CPTColor.red()
        
        let symbol2 = CPTPlotSymbol.ellipse()
        symbol2.fill = CPTFill(color: CPTColor.red())
        symbol2.lineStyle = symbolLineStyle2
        symbol2.size = CGSize(width: 3.0, height: 3.0)
        linePlot2?.plotSymbol = symbol2;
        
        //PTH style
        let lineStylePTH = linePlot3?.dataLineStyle!.mutableCopy() as! CPTMutableLineStyle
        lineStylePTH.lineWidth = 1
        lineStylePTH.lineColor = CPTColor.green()
        
        linePlot3!.dataLineStyle = lineStylePTH;
        linePlot4!.dataLineStyle = lineStylePTH;
        linePlot5!.dataLineStyle = lineStylePTH;
        
        //Light
        let lineStyleLight = linePlot6?.dataLineStyle!.mutableCopy() as! CPTMutableLineStyle
        lineStyleLight.lineWidth = 1
        lineStyleLight.lineColor = CPTColor.blue()
        
        linePlot6!.dataLineStyle = lineStyleLight;
        
        //Accel style
        let lineStyleAccel = linePlot7?.dataLineStyle!.mutableCopy() as! CPTMutableLineStyle
        lineStyleAccel.lineWidth = 1
        lineStyleAccel.lineColor = CPTColor.black()
        
        linePlot7!.dataLineStyle = lineStyleAccel;
        linePlot8!.dataLineStyle = lineStyleAccel;
        linePlot9!.dataLineStyle = lineStyleAccel;
        
        //set graph grid lines
        let gridLineStyle = CPTMutableLineStyle()
        gridLineStyle.lineColor = CPTColor.gray()
        gridLineStyle.lineWidth = 0.5
        xAxis?.majorGridLineStyle = gridLineStyle
        yAxis?.majorGridLineStyle = gridLineStyle
        
    }
    
    func resetPlotRange()
    {
        
        plotXMaxRange = 121
        plotXMinRange = -1
        plotYMaxRange = 310
        plotYMinRange = -1
        plotXInterval = 20
        plotYInterval = 50
        
        let plotSpace = graph?.defaultPlotSpace as! CPTXYPlotSpace
        
        plotSpace.xRange = CPTPlotRange(location: NSNumber(value: plotXMinRange!), length: NSNumber(value: plotXMaxRange!))
        plotSpace.yRange = CPTPlotRange(location: NSNumber(value: plotYMinRange!), length: NSNumber(value: plotYMaxRange!))
    }
    
    func clearUI()
    {
        //function not used right now but will be useful down the road
        
        S1C1.text = "-";
        S1C2.text = "-";
        S1C3.text = "-";
        S1C4.text = "-";
        S1C5.text = "-";
        S1C6.text = "-";
        S1C7.text = "-";
        S1C8.text = "-";
        S1C9.text = "-";
        S1C10.text = "-";
        
        // Clear and reset the graph
        xValues?.removeAllObjects()
        
        ValuesCH1?.removeAllObjects()
        ValuesCH2?.removeAllObjects()
        ValuesCH3?.removeAllObjects()
        ValuesCH4?.removeAllObjects()
        ValuesCH5?.removeAllObjects()
        ValuesCH6?.removeAllObjects()
        ValuesCH7?.removeAllObjects()
        ValuesCH8?.removeAllObjects()
        ValuesCH9?.removeAllObjects()
        
        resetPlotRange()
        graph?.reloadData()

    }
    
    //high quality timestamps for plotting.
    static func longUnixEpoch() -> NSDecimalNumber
    {
        return NSDecimalNumber(value: Date().timeIntervalSince1970 as Double)
    }
    
    //MARK: - CPTPlotDataSource
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(ValuesCH1!.count)
    }
    
    //this is critical for the reload function
    func number(for plot: CPTPlot, field fieldEnum: UInt, record idx: UInt) -> Any? {
        
        let fieldVal  = NSInteger(fieldEnum)
        let plotField = CPTScatterPlotField(rawValue: fieldVal)
        let plotID    = plot.identifier as! String
        
        if (plotField! == .Y) && (plotID == "PlotTime")
        {
            return ValuesCH1?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotBattery")
        {
            return ValuesCH2?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotPressure")
        {
            return ValuesCH3?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotTemperature")
        {
            return ValuesCH4?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotHumidity")
        {
            return ValuesCH5?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotIntensity")
        {
            return ValuesCH6?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotAx")
        {
            return ValuesCH7?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotAy")
        {
            return ValuesCH8?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .Y) && (plotID == "PlotAz")
        {
            return ValuesCH9?.object(at: Int(idx)) as AnyObject?
        }
        else if (plotField! == .X)
        {
            // The xValues stores timestamps. To show them starting from 0 we have to subtract the first one.
            return (xValues?.object(at: Int(idx)) as! NSDecimalNumber).subtracting(xValues?.firstObject as! NSDecimalNumber)
        }
        else
        {
            return nil
        }
        
    }
    
    func plotSpace(_ space: CPTPlotSpace, shouldScaleBy interactionScale: CGFloat, aboutPoint interactionPoint: CGPoint) -> Bool {
        return false
    }
    
    func plotSpace(_ space: CPTPlotSpace, willDisplaceBy proposedDisplacementVector: CGPoint) -> CGPoint {
        return CGPoint(x: proposedDisplacementVector.x, y: 0)
    }
    
    func plotSpace(_ space: CPTPlotSpace, willChangePlotRangeTo newRange: CPTPlotRange, for coordinate: CPTCoordinate) -> CPTPlotRange? {
        // The Y range does not change here
        if coordinate == CPTCoordinate.Y {
            return newRange;
        }
        
        // Adjust axis on scrolling
        let axisSet = space.graph?.axisSet as! CPTXYAxisSet
        
        if newRange.location.intValue >= plotXMinRange! {
            // Adjust axis to keep them in view at the left and bottom;
            // adjust scale-labels to match the scroll.
            axisSet.yAxis!.orthogonalPosition = NSNumber(value: newRange.locationDouble - Double(plotXMinRange!))
            return newRange
        }
        axisSet.yAxis!.orthogonalPosition = 0
        return CPTPlotRange(location: NSNumber(value: plotXMinRange!), length: NSNumber(value: plotXMaxRange!))
    }

    func actOnSpecialNotification() {
        
        //add the data to record
        ValuesCH1?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.ticks % 100) as Int))
        ValuesCH2?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.battery) as Int))
        
        ValuesCH3?.add(NSDecimalNumber(value: (DataModel.sharedInstance.pressure) - 980.0 as Double))
        ValuesCH4?.add(NSDecimalNumber(value: DataModel.sharedInstance.temperature as Double))
        ValuesCH5?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.humidity) as Int))
        
        ValuesCH6?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.lightIntensity) as Int))
        
        ValuesCH7?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.accelX) as Int))
        ValuesCH8?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.accelY) as Int))
        ValuesCH9?.add(NSDecimalNumber(value: Int(DataModel.sharedInstance.accelZ) as Int))
        
        //and update the text field
        self.S1C1.text = "\(Int(DataModel.sharedInstance.ticks))"
        self.S1C2.text = "\(Int(DataModel.sharedInstance.battery))"
        
        self.S1C3.text = String(format:"%.1f", DataModel.sharedInstance.pressure)
        self.S1C4.text = String(format:"%.1f", DataModel.sharedInstance.temperature)
        self.S1C5.text = "\(Int(DataModel.sharedInstance.humidity))"
        
        self.S1C6.text = "\(Int(DataModel.sharedInstance.lightIntensity))"
        
        self.S1C7.text = String(format:"%.1f", DataModel.sharedInstance.accelX)
        self.S1C8.text = String(format:"%.1f", DataModel.sharedInstance.accelY)
        self.S1C9.text = String(format:"%.1f", DataModel.sharedInstance.accelZ)
        
        self.S1C10.text = "\(Int(DataModel.sharedInstance.storage))"


        // Also, we save the time when the data was received
        // 'Last' and 'previous' values are timestamps of those values. 
        // We calculate them to know whether we should automatically scroll the graph
        var lastValue : NSDecimalNumber
        var firstValue : NSDecimalNumber
        
        if (xValues?.count)! > 0 {
            lastValue  = xValues?.lastObject as! NSDecimalNumber
            firstValue = xValues?.firstObject as! NSDecimalNumber
        } else {
            lastValue  = 0
            firstValue = 0
        }
        
        let previous : Double = lastValue.subtracting(firstValue).doubleValue
        xValues?.add(DebugViewController.longUnixEpoch())
        
        lastValue  = xValues?.lastObject as! NSDecimalNumber
        firstValue = xValues?.firstObject as! NSDecimalNumber
        let last : Double = lastValue.subtracting(firstValue).doubleValue
        
        // Here we calculate the max value visible on the graph
        let plotSpace = graph!.defaultPlotSpace as! CPTXYPlotSpace
        
        let max = plotSpace.xRange.locationDouble + plotSpace.xRange.lengthDouble
        
        if last > max && previous <= max {
            let location = Int(last) - plotXMaxRange! + 1
            plotSpace.xRange = CPTPlotRange(location: NSNumber(value: (location)), length: NSNumber(value: plotXMaxRange!))
        }
        
        plotSpace.yRange = CPTPlotRange(location: NSNumber(value: 0), length: NSNumber(value: 105))
        
        graph?.reloadData()

        //update the battery icon
        let batteryLevel = DataModel.sharedInstance.battery
        let text = "\(batteryLevel)%"
        self.battery.setTitle(text, for: UIControlState.disabled)


        }

}

