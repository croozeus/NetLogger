<p align="center" >
  <img src="https://raw.githubusercontent.com/croozeus/NetLogger/master/NetLogger.png" alt="NetLogger" title="NetLogger">
</p>

<p align="center">
[![CI Status](https://img.shields.io/travis/croozeus/NetLogger.svg?style=flat)](https://travis-ci.org/croozeus/NetLogger)
[![Version](https://img.shields.io/cocoapods/v/NetLogger.svg?style=flat)](https://cocoapods.org/pods/NetLogger)
[![License](https://img.shields.io/cocoapods/l/NetLogger.svg?style=flat)](https://cocoapods.org/pods/NetLogger)
[![Platform](https://img.shields.io/cocoapods/p/NetLogger.svg?style=flat)](https://cocoapods.org/pods/NetLogger)
</p>

NetLogger is a library to keep track of all the network requests made by your app. The library can be used to track all HTTP requests (`GET`, `POST`, `PUT`, `UPDATE`, `HEAD`, etc.) and see details of all the requests made. The details include info like request URL, request & response headers, request and response body, request and response time, round trip duration, etc. amongst other details. 

The library can be used for debugging network calls, see the exact url and payload sent or received in the request right from with the app interface. Using the library enables a special debug user interface that can be launched within the app. All the details of the network requests can be viewed within this UI itself. There is no need for the device to be connected to XCode (not even wirelessly!) when debugging network requests.

## Installation

NetLogger is distributed as a cocoapod, so if you are familiar with using cocoapods this should be a breeze. Include the following in your pod file and do 'pod install' or 'pod update'.

```ruby
pod 'NetLogger'
```

## Usage

The usage is as simple as including the following lines in your `AppDelegate.m` file.

1) Import the `NetLogger.h` file in your `AppDelegate.m`

```objective-c
#import <NetLogger/NetLogger.h>
```

2) In `application:didFinishLaunchingWithOptions:` method add the following lines.

```objective-c
NetLogger* nl = [NetLogger sharedManager];
[nl  show:ALIGN_RIGHT];
```

That's it. Now run your application, you should see a launch button floating on the right of your app. Clicking this button would launch the NetLogger interface.

Currently, the NetLogger launch button can be shown in either left, right, top or bottom positions. You may use `ALIGN_RIGHT`, `ALIGN_LEFT`, `ALIGN_TOP` or `ALIGN_BOTTOM` as you like. 

## Example

If you like, we have included a small example project that you could quickly try. To run the example project, clone the repo, and run `pod install` from the Example directory first.

## NetLogger Interface

The NetLogger launch button should show up on the right of your app if you enabled the pod properly. The launch button has high z-index so it would typically appear on top of your app at all times, except when you use system dialogs or keyboards.

Clicking the launch button would present the NetLogger interface. The first screen shows you a list of network requests with the time of requests. It also lists the type of request, for e.g. `GET`, `POST`, `PUT`, etc. A circle of color (Yellow, Red or Green) is shown beside each request. 

1) If the color of the circle is YELLOW - the request is made and response is awaited. 
2) If the color is RED - the request was made and response is received, however the response code is not HTTP 2XX (200, 201, 202, etc.). The response is likely to be 4XX or 5XX. 
3) If the color is GREEN - the request was made and response code received is HTTP 2XX.

The list interface is dyanamic and updated whenever the requests are made through the app. 

Clicking on a request would show the details of the request. The details would include info like request URL, request & response headers, request and response body, request and response time, round trip duration, etc. amongst other details. 

## Troubleshooting & Feedback

The best place to ask for help would be the GitHub issues section. Just post what you need help with and we will get in touch. 

If you have any feedback, please do not hesitate to share with us. We plan to update the library from time to time to make it more powerful!


## Credits & Disclaimer

NetLogger is owned and mantained by [VersionN Studios](https://versionn.com). This library is meant for debugging purposes and should not be shipped with the app. 

## License

NetLogger is available under the BSD license. See the LICENSE file for more info.
