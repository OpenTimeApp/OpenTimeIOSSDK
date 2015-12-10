# OpenTimeIOSSDK

## Getting started 
You will need the following dependencies in your Pods file

    pod 'AFNetworking', '~> 2.4'
    pod 'libPhoneNumber-iOS', '~> 0.8.7'

You must be on iOS 8.0 or later and specify it in your Pods file like so: 

    platform :ios, '8.0'

You must use frameworks in your Pods file spec like so: 

    use_frameworks!

If you get an error about common crypto check module.map file at CommonCrypto/module.map
Make sure the path pointing to the CommonCrypto library is valid. If it is not then find out where it is on your computer and update the path. 
The paths could be slightly different but should be very similiar. For example this path exists on my machine: 

    /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS9.0.sdk/usr/include/CommonCrypto/

Make sure it exists on yours

### Add the library folders
To use the library add a reference to [all the files in the OpenTimeSDK folder](https://github.com/OpenTimeApp/OpenTimeIOSSDK/tree/master/OpenTimeSDK). You can do this in Xcode by going to File->Add files to [your project name]. Then select all the files in the OpenTimeSDK folder and complete the dialog.

### Get an API key
To get an API key please email josh.woodcock@opentimeapp.com

1. Open OpenTimeSDKTests/Config.plist
2. Set the value of OPENTIME_KEY to your test key. It won't work with your live key.
3. If you are contributing to the project use the following to ignore changes to the file so you don't commit your own API key:
```bash
git update-index --assume-unchanged OpentimeSDKTests/Config.plist
```

### Run the tests
The best way to get started is to run the tests to make sure everything is working 

### Example
Initialize OpenTime before you use it anywhere

    OpenTimeSDK.initSession("Your really awesome test key goes here", inTestMode: true);
    
Set the credentials for the user like so: 

    OpenTimeSDK.session.setPlainTextCredentials(1, password: "I love testing");
    
Get the current user's availability like so:
    
    AvailabilityAPI.getAllMyAvailability { (response: GetAllMyAvailabilityResponse) -> Void in
        if(response.success == true){
            print("Yippee!")
        }
    }
    
    
When you're done testing you can take test mode off like so: 
    
    OpenTimeSDK.initSession("Your realy awesome live key goes here");
    
If you want to change the server use: 

    OpenTimeSDK.session.setServer("https://myotherawesomeserver.opentimeapp.com")
    
## License

AFNetworking is released under the MIT license. See LICENSE for details.
