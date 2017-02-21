# OpenTimeIOSSDK

## Getting started 
To install use

    pod 'OpenTimeSDK', '~> 1.0.0'

You must be on iOS 9.0 or later and specify it in your Pods file like so: 

    platform :ios, '9.0'

You must use frameworks in your Pods file spec like so: 

    use_frameworks!

### Get an API key
To get an API key please email josh.woodcock@opentimeapp.com

1. Open OpenTimeSDKTests/Config.plist
2. Set the value of OPENTIME_KEY to your test key. It won't work with your live key.
3. If you are contributing to the project use the following to ignore changes to the file so you don't commit your own API key:
```bash
git update-index --assume-unchanged Example/Tests/Config.plist
```

### Run the tests
The best way to get started is to run the tests to make sure everything is working 

### Example
Initialize OpenTime before you use it anywhere

    OpenTimeSDK.initSession("Your really awesome test key goes here", inTestMode: true);
    
Set the credentials for the user like so: 

    OpenTimeSDK.session.setPlainTextCredentials(1, password: "I love testing");
    
Get the current user's availability like so:
    
    OTAvailabilityAPI.getAllMyAvailability { (response: GetAllMyAvailabilityResponse) -> Void in
        if(response.success == true){
            print("Yippee!")
        }
    }
    
    
When you're done testing you can take test mode off like so: 
    
    OpenTimeSDK.initSession("Your realy awesome live key goes here");
    
If you want to change the server use: 

    OpenTimeSDK.session.setServer("https://myotherawesomeserver.opentimeapp.com")
    
## License

OpenTimeSDK is released under the MIT license. See LICENSE for details.
