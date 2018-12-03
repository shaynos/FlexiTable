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
consists of 3 main parts:

-   HeaderBackgroundView (UIView subclass which acts as the header for the FTVC,
    reacts to scroll events)

-   SegmentedHeaderView (contains a UICollectionView for selecting different
    sets of data to display in the table)

-   UITableView (contains a UICollectionView for selecting different sets of
    data to display in the table)

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
![](animated.gif)
![](animated 2.gif)
![](animated 3.gif)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Features
--------

-   [x] Tested on iOS 9 +

-   [X] Customisable

-   [x] Built to work with all screen sizes and types

-   [x] Fully configurable header

-   [x] Comes with 2 different types of animated headers (Parallax and Profile)

-   [x] Build your own animated header that responds to UITableView scroll

Requirements
------------

-   iOS 9.0+

Installation
------------

#### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by
adding it to your `Podfile`:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ruby
pod 'FlexiTable'
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
import UIKit
import FlexiTable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Usage example
-------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift
import FlexiTable
class MyViewController: FlexiTableViewController, SegmentedHeaderDelegate{
override func viewDidLoad() {
    self.segmentedHeaderView = SegmentedHeaderView.init(segmentTitles: ["No Sections", "Sections"], viewHeight: 50, horizontalPadding: 20)
    self.foregroundView = ParallaxHeaderView.init(title: "Parallax Header", font: UIFont.systemFont(ofSize: 22), textColor: UIColor.white, headerPosition: .center)
    self.backgroundView = ParallaxBackgroundView.init(image: UIImage(named: "concert.jpeg")!)
}

func segmentedHeaderViewSelectedButtonAtIndex(index: NSInteger, title: String) {
    print("SEG SELECTED == ", index)
}
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Contribute
----------

We would love you for the contribution to **FlexiTable**, check the `LICENSE`
file for more info.

 

Distributed under the MIT license. See `LICENSE` for more information.

[https://github.com/shaynos/FlexiTable](https://github.com/dbader/)
