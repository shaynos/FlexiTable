FlexiTable
==========

>   FlexiTable is a UIViewController subclass which enables you to cycle through
>   any number of sets of data in UITableView by using a SegmentedHeaderView as
>   a sticky header for the tableView.  
>     
>   FlexiTable also provides an optional header view above the table which can
>   respond to scroll events, making subtle animations and custom header designs
>   easy to implement.

<a href="https://imgflip.com/gif/2o1085"><img src="https://i.imgflip.com/2o1085.gif" title="made at imgflip.com"/></a>
=======
Example
-------

<a href="https://imgflip.com/gif/2o109l"><img src="https://i.imgflip.com/2o109l.gif" title="made at imgflip.com"/></a>

The main component of FlexiTable is the FlexiTableViewController (FTVC) which
consists of 3 main parts:

-   FlexiHeaderView (UIView subclass which acts as the header for the FTVC,
    reacts to scroll events)

-   SegmentedHeaderView (contains a UICollectionView for selecting different
    sets of data to display in the table)

-   UITableView

How does it work
----------------
FlexiTable uses anchors to create a flexible space above the table which is used to layer multiple views. An empty tableHeaderView is added to the tableView to accomodate these views. 

#### 1- FlexiHeaderView
FlexiHeaderView is a UIView subclass which acts as the header for the FlexiTableViewController, it reacts to scroll events by shrinking or expanding depending on which way the user is scrolling and the contentOffset of the tableView.

#### 2- SegmentedHeaderView
SegmentedHeaderView is a UICollectionView subclass which acts as the header for the tableView, it reacts to scroll events by moving with the tableView content as the user scrolls. It will stick to the top of the tableView to ensure that it is always present on the screen. A user can change the content of the tableView by selecting an option from the SegmentedHeaderView.


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

Usage example
-------------

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift
class MyViewController: FlexiTableViewController, SegmentedHeaderDelegate{
    
    override func viewDidLoad() {
        self.segmentedHeaderView = SegmentedHeaderView.init(segmentTitles: ["No Sections", "Sections"], viewHeight: 50, horizontalPadding: 20)
        self.segmentedHeaderView?.delegate = self
        self.foregroundView = ParallaxHeaderView.init(title: "Parallax Header", font: UIFont.systemFont(ofSize: 22), textColor: UIColor.white, headerPosition: .center)
        self.backgroundView = ParallaxBackgroundView.init(image: UIImage(named: "concert.jpeg")!)
    }
    
    func segmentedHeaderViewSelectedButtonAtIndex(index: NSInteger, title: String) {
        print("SEG SELECTED == ", index)
    }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Customising the SegementedHeader
--------------------------------

The titles, font, selectedcolor, deselectedColor, and horizontal padding of the segmented header can be customised. If the widths of all of the titles does not take up the full width of the screen then they will be automatically padded to ensure the UI still looks great!

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
        let seg = SegmentedHeaderView.init(segmentTitles: ["Option 1", "Option 2", "Option 3", "Option 4"], viewHeight: 50, horizontalPadding: 20)
        seg.delegate = self
        seg.buttonFont = UIFont(name: "KohinoorBangla-Semibold", size: 16)!
        seg.selectedColor = UIColor.blue
        seg.deselectedColor = UIColor.lightGray
        self.segmentedHeaderView = seg
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Customising the FlexiHeaderView
-------------------------------
There are two components which are used to make up the FlexiHeader. They are referred to as headerBackgroundView, and headerForegroundView. I decided to use two views here to make it less confusing when laying out for iPhoneX. The only difference between them is that the headerBackgroundView topAnchor is anchored to the topAnchor of the frame, while the headerForegroundView topAnchor is anchored to the bottom of the safeAreaLayout bottomAnchor. They both take up the full width of the screen, the bottom of both of these views are anchored to the topAnchor of the SegmentedHeaderView. When the table scrolls, the constraints cause these views to shrink. You can use this action to perform some cool animations by using some clever constraint layouts.

The headerBackgroundView will never shrink to less then the height of the navBar + the height of the statusBar.
The headerForegroundView will never shrink to less then the height of the navBar.

Using a FlexiHeader is optional. If you choose to not add a headerBackgroundView or headerForegroundView then a NavBar will be used instead.

FlexiTable comes with 3 types of HeaderBackgroundView which you can use, or you can build your own.

#### 1. ParallaxBackgroundView:

ParallaxBackgroundView is simply an UIImageView which takes up the full frame of the header, it's content mode is set to .scaleAspectFill so that is the view shrinks when the table is scrolled, it gives the image the parallax effect. ParrallaxHeaderView is intended to be used as the headerBackgroundView component of FlexiTable.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
        let backgroundView = ParallaxBackgroundView.init(image: UIImage(named: "concert.jpeg")!)
        self.backgroundView = backgroundView
        self.setTableHeaderForegroundHeight(height: UIScreen.main.bounds.size.width * 0.6)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### 2. ParallaxHeaderView:

ParallaxHeaderView is simply a label centered horizontally to the middle of a FlexiHeaderView. You can choose to vertical of position the label to be top, center or bottom.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
        let foregroundView = ParallaxHeaderView.init(title: "Parallax Header", font: UIFont.systemFont(ofSize: 22), textColor: UIColor.white, headerPosition: .center)
        foregroundView.headerLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24)!
        self.foregroundView = foregroundView
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### 3. ProfileHeaderView:

ProfileHeaderView contains a rounded UIImageView, headerLabel and subtitleLabel. As a user scrolls the UIImageView shrinks and the position of the labels move in sync with the UIImageView.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
        let foregroundView = ProfileHeaderView(maxImageHeight: 100, image: UIImage(named: "person.jpeg")!, title: "John", subtitle: "John is awesome")
        foregroundView.titleLabel.font = UIFont(name: "KohinoorBangla-Semibold", size: 24)!
        foregroundView.subtitleLabel.font = UIFont(name: "KohinoorBangla-Light", size: 18)!
        
        foregroundView.titleLabel.textColor = UIColor.white
        foregroundView.subtitleLabel.textColor = UIColor.white
        
        self.foregroundView = foregroundView
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### Build your own FlexiHeaderView

You can always subclass FlexiHeaderView and build your own (FlexiHeaderView is simply a UIView which listens for TableView scroll events.) If you want to perform animations you can override the 'flexiTableDidScroll(offset: CGFloat)' function to listen for scroll events from the tableView. For example, you may want to update the constant of an NSLayoutConstraint, or change the alpha value of a label when the table scrolls:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
    override public func flexiTableDidScroll(offset: CGFloat) {
        subtitleLabel.alpha = 1 - offset / 100
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
    }
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Segmented Header Delegate Methods
---------------------------------

There are two delegate methods which are called when the SegmentedHeaderView is selected:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
    func segmentedHeaderViewSelectedButtonAtIndex(index: NSInteger, title: String)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ swift    
    func segmentedHeaderShouldSelectSegement(atIndex: NSInteger, fromIndex: NSInteger) -> Bool
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Contribute
----------

We would love you to contribute to **FlexiTable**

 

Distributed under the MIT license. See `LICENSE` for more information.

[https://github.com/shaynos/FlexiTable](https://github.com/shaynos/FlexiTable)
