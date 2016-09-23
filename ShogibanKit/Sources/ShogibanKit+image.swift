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


private func degreesToRadians(_ value: CGFloat) -> CGFloat {
	return value * CGFloat(M_PI) / 180.0
}
 
private func radiansToDegrees (_ value: CGFloat) -> CGFloat {
	return value * 180.0 / CGFloat(M_PI)
}

extension 局面型 {

	func imageForSize(_ size: CGSize) -> CGImage {
		let width = Int(size.width)
		let height = Int(size.height)
		let bitsPerComponent = 8
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo =  CGImageAlphaInfo.premultipliedLast
		let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: width * bitsPerComponent, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

		let rect = CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height))
		context.clear(rect)
		context.translateBy(x: 0, y: CGFloat(height))
		context.scaleBy(x: 1, y: -1)

		let size = rect.size
		let cellWidth: CGFloat = size.width / 11.0
		let cellHeight: CGFloat = size.height / 11.0

		// (0, 0) is left bottom
		let left = floor(cellWidth * 1)
		let right = floor(cellWidth * 10)
		let bottom = floor(cellHeight * 1)
		let top = floor(cellHeight * 10)
		
//		let context = UIGraphicsGetCurrentContext()!
		context.setStrokeColor(XColor.black.cgColor)
		for col in 0...9 {
			let x = floor(left + cellWidth * CGFloat(col))
			context.move(to: CGPoint(x: x, y: top))
			context.addLine(to: CGPoint(x: x, y: bottom))
			context.strokePath()
		}
		for row in 0...9 {
			let y = floor(bottom + cellHeight * CGFloat(row))
			context.move(to: CGPoint(x: left, y: y))
			context.addLine(to: CGPoint(x: right, y: y))
			context.strokePath()
		}

		let fontSize = floor(fmin(cellHeight, cellWidth) * 0.85)
		let font1 = CTFontCreateWithName("HiraKakuProN-W3" as CFString?, fontSize, nil)
		let font2 = CTFontCreateWithName("HiraKakuProN-W6" as CFString?, fontSize, nil)
		let vectors: [先手後手型: CGFloat] = [.先手: 1, .後手: -1]

		for 段 in 段型.全段 {
			for 筋 in 筋型.全筋 {
				let x = floor(right - (cellWidth * CGFloat(筋.rawValue + 1)))
				let y = floor(top - (cellHeight * CGFloat(8 - 段.rawValue)))
//				let rect = CGRectMake(x, y, floor(cellWidth), floor(cellHeight))
				let 位置 = 位置型(筋: 筋, 段: 段)
				let 升 = self[位置]
				if let 駒面 = 升.駒面, let 先後 = 升.先後 {
					let string = 駒面.string
					let characters = [UniChar](string.utf16)
					var glyphs = [CGGlyph](repeating: 0, count: characters.count)
					let font: CTFont
					switch 直前の指手 {
					case .動(_, _, let 移動後の位置, _)? where 移動後の位置 == 位置: font = font2
					case .打(_, let 打位置, _)? where 打位置 == 位置: font = font2
					default: font = font1
					}
					let result = CTFontGetGlyphsForCharacters(font, characters, &glyphs, characters.count)
					assert(result)
					let descent = CTFontGetDescent(font)
					let positions = [CGPoint](repeating: CGPoint(x: 0, y: descent), count: characters.count)
					var rects = [CGRect](repeating: CGRect.zero, count: characters.count)
					CTFontGetBoundingRectsForGlyphs(font, .horizontal, glyphs, &rects, glyphs.count)
					let offsetX = ((cellWidth - rects[0].width) / 2) * vectors[先後]!
					context.saveGState()
					context.translateBy(x: x + offsetX, y: y)
					context.scaleBy(x: 1, y: -1)
					switch 先後 {
					case .先手:
						context.translateBy(x: 0, y: descent)
						break
					case .後手:
						context.translateBy(x: cellWidth, y: cellHeight)
						context.rotate(by: degreesToRadians(180))
						context.translateBy(x: 0, y: descent)
					}
					CTFontDrawGlyphs(font, glyphs, positions, glyphs.count, context)
					context.restoreGState()
				}
			}
		}

		let descent = CTFontGetDescent(font1)

		for 先後 in [先手後手型.先手, .後手] {
			context.saveGState()
			let 持駒 = self.持駒(先後)
			let 記号: String
			switch 先後 {
			case .先手: 記号 = "☗"
			case .後手: 記号 = "☖"
			}

			let attributes = [NSFontAttributeName: font1]
			let attributedString = NSAttributedString(string: 記号 + 持駒.漢数字表記, attributes: attributes)
			let line = CTLineCreateWithAttributedString(attributedString)
			context.textMatrix = CGAffineTransform(scaleX: 1, y: -1)
			context.translateBy(x: cellWidth, y: cellHeight * 11)

			switch 先後 {
			case .先手:
				context.translateBy(x: 0, y: -descent)
			case .後手:
				context.translateBy(x: cellWidth * 9, y: -(cellHeight * 11))
				context.rotate(by: degreesToRadians(180))
				context.translateBy(x: 0, y: -descent)
			}

			CTLineDraw(line, context)
			context.restoreGState()
		}

		return context.makeImage()!
	}

}
