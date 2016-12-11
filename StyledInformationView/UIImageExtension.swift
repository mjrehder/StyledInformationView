//
//  UIImageExtension.swift
//  StyledInformationView
//
//  Created by Martin Rehder on 22.10.2016.
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

extension UIImage {
    func tint(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let ctx = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(ctx, 0, self.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        CGContextSetBlendMode(ctx, CGBlendMode.Normal)
        
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        CGContextClipToMask(ctx, area, self.CGImage!)
        CGContextFillRect(ctx, area)
        
        defer { UIGraphicsEndImageContext() }
        
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
