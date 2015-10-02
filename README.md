# EasyPostHelper-iOS
Access EasyPost Shipping API via iOS

![alt tag](http://asdfghjkl.me/wp-content/uploads/2015/10/IMG_5041_iphone6plus_gold_portrait.png)

EasyPostHelper-iOS
============

Simple implementation of the EasyPost API for iOS to get shipment rates.  


Dependencies
=================
AFNetworking- https://github.com/AFNetworking/AFNetworking
*recommend Cocoapods to install

Installation
=================

1. copy and import  own project.
2. `#import "EasyPostHelper.h"`
3. set your EASYPOST_APIKEY in EasyPostHelper.m
 

Usage
=================


1. Create sender, receiver and parcel size and weight dictionaries
--------------------

```
NSMutableDictionary *dictionaryForParcel = [NSMutableDictionary dictionaryWithObjectsAndKeys:
@"8",@"parcel[length]",
@"6",@"parcel[width]",
@"5",@"parcel[height]",
@"10",@"parcel[weight]",
nil];

NSMutableDictionary *shipFromDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
@"Frantz Romain",@"address[name]",
@"",@"address[company]",
@"2424 Morris Ave",@"address[street1]",
@"",@"address[street2]",
@"Union",@"address[city]",
@"NJ",@"address[state]",
@"07083",@"address[zip]",
@"US",@"address[country]",
@"(201)974-5050",@"address[phone]",
@"frantz@apple.com",@"address[email]",
nil];

NSMutableDictionary *shipToDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
@"Bill Gates",@"address[name]",
@"",@"address[company]",
@"1 Microsoft Way",@"address[street1]",
@"",@"address[street2]",
@"Redmond",@"address[city]",
@"WA",@"address[state]",
@"98052",@"address[zip]",
@"US",@"address[country]",
@"(425)882-8080",@"address[phone]",
@"bill@microsoft.com",@"address[email]",
nil];
```

2. How get shipment rate data from EasyPost
--------------------
```
//This example sends an rates response object to the next viewcontroller in my project

[EasyPostHelper getShipmentrates:shipFromDict from:shipFromDict forParcel:dictionaryForParcel completionHandler:^(id responseObject, NSError *error) {
//Do something after data is returned from the response object

UIStoryboard *storyboard = self.storyboard;
PlaceOrderViewController *orderDetails = [storyboard instantiateViewControllerWithIdentifier:@"PlaceOrderViewController"];

orderDetails.rates = responseObject; //orderDetails.rates is an NSArray
//dismiss loading view and send user on if no errors were found and all forms copleted
[activityView stopAnimating];
[self.navigationController pushViewController:orderDetails animated:YES];
}];


```      




MIT License
--------------------
The MIT License (MIT)

Copyright (c) 2015 Frantzdy Romain

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
