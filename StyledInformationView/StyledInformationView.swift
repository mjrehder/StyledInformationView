//
//  StyledInformationView.swift
//  StyledInformationView
//
//  Created by Martin Rehder on 11.12.2016.
/*
 * Copyright 2016-present Martin Jacob Rehder.
 * http://www.rehsco.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import UIKit
import StyledOverlay
import MJRFlexStyleComponents

public enum StyledInformationMenuAlignment {
    case center(maxWidth: CGFloat)
    case left(maxWidth: CGFloat)
    case right(maxWidth: CGFloat)
}

public class StyledInformationView: StyledBase3Overlay, FlexMenuDataSource {
    private var menu = FlexMenu(frame: CGRectMake(0,0,10,10))
    public var upperLabel = FlexTextView()
    public var lowerText = FlexTextView()
    
    public var menuItems: [StyledInformationMenuItem]? {
        didSet {
            self.menu.menuDataSource = self
            self.menu.setNeedsLayout()
        }
    }
    
    public var menuAlignment: StyledInformationMenuAlignment = .center(maxWidth: CGFloat.infinity) {
        didSet {
            self.layoutMenu()
        }
    }

    public var headerText: NSAttributedString? = nil {
        didSet {
            self.updateHeaderLabel()
        }
    }

    public var headerTextAlignment: NSTextAlignment = .Center {
        didSet {
            self.updateHeaderLabel()
        }
    }

    public var detailText: NSAttributedString? = nil {
        didSet {
            self.updateTextView()
        }
    }
    
    public var detailTextAlignment: NSTextAlignment = .Center {
        didSet {
            self.updateTextView()
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initInformationView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initInformationView()
    }

    func initInformationView() {
        self.upperView.addSubview(self.upperLabel)
        self.centerView.addSubview(self.menu)
        self.lowerView.addSubview(self.lowerText)
        
        self.lowerText.textView.textAlignment = .Center
        self.prepareTextView(self.lowerText.textView)
        self.lowerText.styleColor = .clearColor()

        self.upperLabel.textView.textAlignment = .Center
        self.prepareTextView(self.upperLabel.textView)
        self.upperLabel.styleColor = .clearColor()

        self.menu.menuInterItemSpacing = 10
        self.menu.menuStyle = .EquallySpaces(thumbPos: .Top)

        self.updateHeaderLabel()
        
        self.upperViewWeight = 10
        self.centerViewWeight = 25
        self.lowerViewWeight = 65
    }
    
    public override func layoutViews() {
        super.layoutViews()
        self.upperLabel.frame = self.upperView.bounds
        self.lowerText.frame = self.lowerView.bounds
        self.layoutMenu()
    }

    private func prepareTextView(textView: UITextView) {
        textView.editable = false
        textView.selectable = false
        textView.userInteractionEnabled = false
        textView.dataDetectorTypes = .None
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.scrollEnabled = false
        textView.contentInset = UIEdgeInsetsZero
        textView.scrollIndicatorInsets = UIEdgeInsetsZero
        textView.contentOffset = CGPointZero
        textView.textContainerInset = UIEdgeInsetsZero
        textView.textContainer.lineFragmentPadding = 0
        textView.backgroundColor = .clearColor()
    }
    
    private func layoutMenu() {
        var bounds = self.centerView.bounds
        switch self.menuAlignment {
        case .center(let maxWidth):
            if maxWidth.isFinite {
                bounds = CGRectMake(bounds.origin.x + (bounds.size.width - maxWidth) * 0.5, bounds.origin.y, maxWidth, bounds.size.height)
            }
        case .left(let maxWidth):
            if maxWidth.isFinite {
                bounds = CGRectMake(bounds.origin.x, bounds.origin.y, maxWidth, bounds.size.height)
            }
        case .right(let maxWidth):
            if maxWidth.isFinite {
                bounds = CGRectMake(bounds.origin.x + (bounds.size.width - maxWidth), bounds.origin.y, maxWidth, bounds.size.height)
            }
        }
        self.menu.frame = bounds
    }
    
    private func updateHeaderLabel() {
        self.upperLabel.textView.attributedText = headerText
        self.upperLabel.textView.textAlignment = self.headerTextAlignment
    }
    
    private func updateTextView() {
        self.lowerText.textView.attributedText = self.detailText
        self.lowerText.textView.textAlignment = self.detailTextAlignment
    }
    
    // MARK: - FlexMenuDataSource
    
    public func menuItemSelected(menu: FlexMenu, index: Int) {
        if let mi = self.menuItemForIndex(menu, index: index) as? StyledInformationMenuItem {
            mi.selectionHandler?()
        }
    }
    
    public func menuItemForIndex(menu: FlexMenu, index: Int) -> FlexMenuItem {
        if let mi = self.menuItems {
            return mi[index]
        }
        return FlexMenuItem(title: "", titleShortcut: "", color: .clearColor(), thumbColor: .clearColor())
    }
    
    public func numberOfMenuItems(menu: FlexMenu) -> Int {
        if let mi = self.menuItems {
            return mi.count
        }
        return 0
    }
}
