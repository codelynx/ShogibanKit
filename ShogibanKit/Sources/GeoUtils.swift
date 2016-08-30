//
//  GeoUtils.swift
//  ZKit
//
//	The MIT License (MIT)
//
//	Copyright (c) 2016 Electricwoods LLC, Kaz Yoshikawa.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy 
//	of this software and associated documentation files (the "Software"), to deal 
//	in the Software without restriction, including without limitation the rights 
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
//	copies of the Software, and to permit persons to whom the Software is 
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in 
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.


import Foundation
import CoreGraphics


func DegreesToRadians(value: CGFloat) -> CGFloat {
	return value * CGFloat(M_PI) / 180.0
}
 
func RadiansToDegrees (value: CGFloat) -> CGFloat {
	return value * 180.0 / CGFloat(M_PI)
}

func CGRectMakeAspectFill(imageSize: CGSize, _ bounds: CGRect) -> CGRect {
	let result: CGRect
	let margin: CGFloat
	let horizontalRatioToFit = bounds.size.width / imageSize.width
	let verticalRatioToFit = bounds.size.height / imageSize.height
	let imageHeightWhenItFitsHorizontally = horizontalRatioToFit * imageSize.height
	let imageWidthWhenItFitsVertically = verticalRatioToFit * imageSize.width
	let minX = CGRectGetMinX(bounds)
	let minY = CGRectGetMinY(bounds)

	if (imageHeightWhenItFitsHorizontally > bounds.size.height) {
		margin = (imageHeightWhenItFitsHorizontally - bounds.size.height) * 0.5
		result = CGRectMake(minX, minY - margin, imageSize.width * horizontalRatioToFit, imageSize.height * horizontalRatioToFit)
	}
	else {
		margin = (imageWidthWhenItFitsVertically - bounds.size.width) * 0.5
		result = CGRectMake(minX - margin, minY, imageSize.width * verticalRatioToFit, imageSize.height * verticalRatioToFit)
	}
	return result;
}

func CGRectMakeAspectFit(imageSize: CGSize, _ bounds: CGRect) -> CGRect {
	let minX = CGRectGetMinX(bounds)
	let minY = CGRectGetMinY(bounds)
	let widthRatio = bounds.size.width / imageSize.width
	let heightRatio = bounds.size.height / imageSize.height
	let ratio = min(widthRatio, heightRatio)
	let width = imageSize.width * ratio
	let height = imageSize.height * ratio
	let xmargin = (bounds.size.width - width) / 2.0
	let ymargin = (bounds.size.height - height) / 2.0
	return CGRectMake(minX + xmargin, minY + ymargin, width, height)
}

func CGSizeMakeAspectFit(imageSize: CGSize, frameSize: CGSize) -> CGSize {
	let widthRatio = frameSize.width / imageSize.width
	let heightRatio = frameSize.height / imageSize.height
	let ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio
	let width = imageSize.width * ratio
	let height = imageSize.height * ratio
	return CGSizeMake(width, height)
}

public func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
	return CGSizeMake(lhs.width * rhs, lhs.height * rhs)
}

