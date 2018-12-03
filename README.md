FlexiTable
==========

>   FlexiTable is a UIViewController subclass which enables you to cycle through
>   any number of sets of data in UITableView by using a SegmentedHeaderView as
>   a sticky header for the tableView.  
>     
>   FlexiTable also provides an optional header view above the table which can
>   respond to scroll events, making subtle animations and custom header designs
>   easy to implement.

<https://swift.org/>

FlexiTable works well with all iPhone screen types and sizes.

 

The main component of FlexiTable is the FlexiTableViewController (FTVC) which
consists of 2 main parts:

-   HeaderBackgroundView (UIView subclass which acts as the header for the FTVC,
    reacts to scroll events)

-   SegmentedHeaderView (contains a UICollectionView for selecting different
    sets of data to display in the table)

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
![](animated.gif)
![](animated 2.gif)
![](animated 3.gif)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Layout
------

-   [x] Feature 1

-   [x] Feature 2

-   [x] Feature 3

-   [x] Feature 4

-   [x] Feature 5

Requirements
------------

-   iOS 9.0+

Installation
------------

#### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by
adding it to your `Podfile`:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ruby
platform :ios, '9.0'
use_frameworks!
pod 'FlexiTable'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
import UIKit
import FlexiTable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Usage example
-------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift
import EZSwiftExtensions
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Contribute
----------

We would love you for the contribution to **FlexiTable**, check the `LICENSE`
file for more info.

 

Meta
----

Your Name – [@YourTwitter](https://twitter.com/dbader_org) –
YourEmail\@example.com

Distributed under the XYZ license. See `LICENSE` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)
