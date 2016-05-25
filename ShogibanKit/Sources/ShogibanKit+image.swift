//
//  ShogibanKit+image.swift
//  ShogibanKit
//
//  Created by Kaz Yoshikawa on 5/24/16.
//  Copyright © 2016 Kaz Yoshikawa. All rights reserved.
//

import Foundation
import CoreGraphics

#if os (OSX)
import Cocoa
typealias XColor = NSColor
typealias XImage = NSImage
#elseif os(iOS)
import UIKit 
typealias XColor = UIColor
typealias XImage = UIImage
#endif

private func DegreesToRadians(value: CGFloat) -> CGFloat {
	return value * CGFloat(M_PI) / 180.0
}

extension 局面型 {

	func imageForSize(size: CGSize) -> CGImage {
		let width = Int(size.width)
		let height = Int(size.height)
		let bitsPerComponent = 8
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo =  CGImageAlphaInfo.PremultipliedLast
		let context = CGBitmapContextCreate(nil, width, height, bitsPerComponent, width * bitsPerComponent, colorSpace, bitmapInfo.rawValue)!

		let rect = CGRectMake(0, 0, CGFloat(width), CGFloat(height))
		CGContextClearRect(context, rect)
		CGContextTranslateCTM(context, 0, CGFloat(height))
		CGContextScaleCTM(context, 1, -1)

		let size = rect.size
		let cellWidth = size.width / 11
		let cellHeight = size.height / 11

		// (0, 0) is left bottom
		let left = floor(cellWidth * 1)
		let right = floor(cellWidth * 10)
		let bottom = floor(cellHeight * 1)
		let top = floor(cellHeight * 10)
		
//		let context = UIGraphicsGetCurrentContext()!
		CGContextSetStrokeColorWithColor(context, XColor.blackColor().CGColor)
		for col in 0...9 {
			let x = floor(left + cellWidth * CGFloat(col))
			print("x: \(col) -> \(x)")
			CGContextMoveToPoint(context, x, top)
			CGContextAddLineToPoint(context, x, bottom)
			CGContextStrokePath(context)
		}
		for row in 0...9 {
			let y = floor(bottom + cellHeight * CGFloat(row))
			print("y: \(row) -> \(y)")
			CGContextMoveToPoint(context, left, y)
			CGContextAddLineToPoint(context, right, y)
			CGContextStrokePath(context)
		}
		
		let fontSize = floor(min(cellHeight, cellWidth) * 0.85)
		let font = CTFontCreateWithName("HiraKakuProN-W3", fontSize, nil)
		let descent = CTFontGetDescent(font)
		//let leading = CTFontGetLeading(font)
		let vectors: [先手後手型: CGFloat] = [.先手: 1, .後手: -1]

		for 段 in 0...8 {
			for 筋 in 0...8 {
				let x = floor(right - (cellWidth * CGFloat(筋 + 1)))
				let y = floor(top - (cellHeight * CGFloat(8 - 段)))
//				let rect = CGRectMake(x, y, floor(cellWidth), floor(cellHeight))
				let 位置 = 位置型(筋: 筋型(筋), 段: 段型(段))!
				print("\(位置)")
				let 升 = self[位置]
				if let 駒面 = 升.駒面, let 先後 = 升.先後 {
					let string = 駒面.string
					let characters = [UniChar](string.utf16)
					var glyphs = [CGGlyph](count: characters.count, repeatedValue: 0)
					let result = CTFontGetGlyphsForCharacters(font, characters, &glyphs, characters.count)
					assert(result)
					let descent = CTFontGetDescent(font)
					let positions = [CGPoint](count: characters.count, repeatedValue: CGPointMake(0, descent))
					var rects = [CGRect](count: characters.count, repeatedValue: CGRectZero)
					CTFontGetBoundingRectsForGlyphs(font, .Horizontal, glyphs, &rects, glyphs.count)
					let offsetX = ((cellWidth - rects[0].width) / 2) * vectors[先後]!
					CGContextSaveGState(context)
					CGContextTranslateCTM(context, x + offsetX, y)
					CGContextScaleCTM(context, 1, -1)
					switch 先後 {
					case .先手:
						CGContextTranslateCTM(context, 0, descent)
						break
					case .後手:
						CGContextTranslateCTM(context, cellWidth, cellHeight)
						CGContextRotateCTM(context, DegreesToRadians(180))
						CGContextTranslateCTM(context, 0, descent)
					}
					CTFontDrawGlyphs(font, glyphs, positions, glyphs.count, context)
					CGContextRestoreGState(context)
				}
			}
		}

		let fontSize2 = floor(min(cellHeight, cellWidth) * 0.85)
		let font2 = CTFontCreateWithName("HiraKakuProN-W3", fontSize2, nil)

		for 先後 in [先手後手型.先手, .後手] {
			CGContextSaveGState(context)
			let 持駒 = self.持駒(先後)
			let 記号: String
			switch 先後 {
			case .先手: 記号 = "☗"
			case .後手: 記号 = "☖"
			}

			let attributes = [NSFontAttributeName: font2]
			let attributedString = NSAttributedString(string: 記号 + 持駒.string, attributes: attributes)
			let line = CTLineCreateWithAttributedString(attributedString)
			CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1, -1))
			CGContextTranslateCTM(context, cellWidth, cellHeight * 11)

			switch 先後 {
			case .先手:
				CGContextTranslateCTM(context, 0, -descent)
			case .後手:
				CGContextTranslateCTM(context, cellWidth * 9, -(cellHeight * 11))
				CGContextRotateCTM(context, DegreesToRadians(180))
				CGContextTranslateCTM(context, 0, -descent)
			}

			CTLineDraw(line, context)
			CGContextRestoreGState(context)
		}

		return CGBitmapContextCreateImage(context)!
	}

}
