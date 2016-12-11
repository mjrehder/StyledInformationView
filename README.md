# StyledInformationView
StyledInformationView is a UIView for displaying a header, a menu and a detailed description. Written in Swift.

![screen shot 2016-12-11 at 18 31 15](https://cloud.githubusercontent.com/assets/476994/21081875/1b2252a2-bfd0-11e6-83e4-b2d4781faf7a.png)

# Usage

From the example project, which results in the screenshot shown above:

```swift
import UIKit
import MJRFlexStyleComponents

class ViewController: UIViewController {
    @IBOutlet weak var infoView: StyledInformationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoView.headerText = NSAttributedString(string: "Information Header")

        let aIcon = UIImage(named: "plus_36pt")
        let ami = StyledInformationMenuItem(title: "", titleShortcut: "", color: .clearColor(), thumbColor: .clearColor(), thumbIcon: aIcon)
        ami.selectionHandler = {
            NSLog("Plus selected")
        }
        let sIcon = UIImage(named: "search_36pt")
        let smi = StyledInformationMenuItem(title: "", titleShortcut: "", color: .clearColor(), thumbColor: .clearColor(), thumbIcon: sIcon)
        smi.selectionHandler = {
            NSLog("Search selected")
        }
        
        self.infoView.menuItems = [ami, smi]
        self.infoView.menuAlignment = .center(maxWidth: 100)
        
        self.infoView.detailText = NSAttributedString(string: "This lower text area contains information you want to provide, such as a description of the actions the user can take.")
    }

}

```


# Installation

## CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add _StyledInformationView_:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ‘9.0’

use_frameworks!
pod ‘StyledInformationView’
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import StyledInformationView` framework into your files.

# License (MIT)

Copyright (c) 2016-present - Martin Jacob Rehder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
