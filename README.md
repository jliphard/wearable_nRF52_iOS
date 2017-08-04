# wearable_iOS
This is a pretty general iOS app for communicating with an nRF52-based wearable. The app assumes you are using your own BLE service, which you have customized in your firmware to suit your particular needs. In general, semi-obviously, you are going to have to modify the BLE service part of the code to get it to work with your wearable. 

The code started out as a simple modification of Nordic's excellent nRF toolbox (https://github.com/NordicSemiconductor/IOS-nRF-Toolbox). 

The major differences are that all data are now contained and passed through a separate datamodel, that the app uses a standard 
tab bar controller to allow the user to navigate among different views, and that we use one DataModel.sharedInstance and NotificationCenter.default.post() to get the various charts and data outlets across all the views all supplied with fresh data from the device.

It should be straightforward to reuse/modify this code for many different wearables. In case you are curious, our hardware contains several sensors, a Nordic nRF52, and some NOR-FLASH for data logging. The major next step will be add data uploading to pubnub and to encrypt/harden the bluetooth, which is wide open right now.   
