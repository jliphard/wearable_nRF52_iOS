# wearable_iOS
This is a pretty general iOS app for communicating with an nRF52-based wearable. 

The app assumes you are using special BLE service, which you have customized in your firmware to your particular needs.

In general, you are going to have to modify the BLE service part of the code to get it to work with your wearable. 

The code starting by modifying Nordic's nRF toolbox (https://github.com/NordicSemiconductor/IOS-nRF-Toolbox). 

The major differences are that all data are now contained and passed through a separate datamodel, and that the app is based on a standard 
tabbed controller. 

It should be straightforward to reuse/modify this code for many different wearables.

Our hardware contains several sensors, a Nordic nRF52, and some NOR-FLASH for data logging.  
