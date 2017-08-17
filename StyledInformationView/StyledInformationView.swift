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

open class StyledInformationView: StyledBase3Overlay {
    fileprivate var menu = FlexMenu(frame: CGRect(x: 0,y: 0,width: 10,height: 10))
    open var upperLabel = FlexTextView()
    open var lowerText = FlexTextView()
    
    open var menuItems: [FlexMenuItem]? {
        didSet {
            self.menu.menuItems = self.menuItems
            self.menu.setNeedsLayout()
        }
    }
    
    open var menuAlignment: StyledInformationMenuAlignment = .center(maxWidth: CGFloat.infinity) {
        didSet {
            self.layoutMenu()
        }
    }
    
    open var headerText: NSAttributedString? = nil {
        didSet {
            self.updateHeaderLabel()
        }
    }
    
    open var headerTextAlignment: NSTextAlignment = .center {
        didSet {
            self.updateHeaderLabel()
        }
    }
    
    open var detailText: NSAttributedString? = nil {
        didSet {
            self.updateTextView()
        }
    }
    
    open var detailTextAlignment: NSTextAlignment = .center {
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
        
        self.lowerText.textView.textAlignment = .center
        self.prepareTextView(self.lowerText.textView)
        self.lowerText.styleColor = .clear
        
        self.upperLabel.textView.textAlignment = .center
        self.prepareTextView(self.upperLabel.textView)
        self.upperLabel.styleColor = .clear
        
        self.menu.menuInterItemSpacing = 10
        self.menu.menuStyle = .equallySpaces(thumbPos: .top)
        
        self.updateHeaderLabel()
        
        self.upperViewWeight = 10
        self.centerViewWeight = 25
        self.lowerViewWeight = 65
    }
    
    open override func layoutViews() {
        super.layoutViews()
        self.upperLabel.frame = self.upperView.bounds
        self.lowerText.frame = self.lowerView.bounds
        self.layoutMenu()
    }
    
    fileprivate func prepareTextView(_ textView: UITextView) {
        textView.isEditable = false
        textView.isSelectable = false
        textView.isUserInteractionEnabled = false
        textView.dataDetectorTypes = UIDataDetectorTypes()
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.isScrollEnabled = false
        textView.contentInset = UIEdgeInsets.zero
        textView.scrollIndicatorInsets = UIEdgeInsets.zero
        textView.contentOffset = CGPoint.zero
        textView.textContainerInset = UIEdgeInsets.zero
        textView.textContainer.lineFragmentPadding = 0
        textView.backgroundColor = .clear
    }
    
    fileprivate func layoutMenu() {
        var bounds = self.centerView.bounds
        switch self.menuAlignment {
        case .center(let maxWidth):
            if maxWidth.isFinite {
                bounds = CGRect(x: bounds.origin.x + (bounds.size.width - maxWidth) * 0.5, y: bounds.origin.y, width: maxWidth, height: bounds.size.height)
            }
        case .left(let maxWidth):
            if maxWidth.isFinite {
                bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: maxWidth, height: bounds.size.height)
            }
        case .right(let maxWidth):
            if maxWidth.isFinite {
                bounds = CGRect(x: bounds.origin.x + (bounds.size.width - maxWidth), y: bounds.origin.y, width: maxWidth, height: bounds.size.height)
            }
        }
        self.menu.frame = bounds
    }
    
    fileprivate func updateHeaderLabel() {
        self.upperLabel.textView.attributedText = headerText
        self.upperLabel.textView.textAlignment = self.headerTextAlignment
    }
    
    fileprivate func updateTextView() {
        self.lowerText.textView.attributedText = self.detailText
        self.lowerText.textView.textAlignment = self.detailTextAlignment
    }
}
