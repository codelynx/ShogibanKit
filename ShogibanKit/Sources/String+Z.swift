//
//  String+Z.swift
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


extension String {

	func stringByAppendingPathExtension(_ str: String) -> String? {
		return (self as NSString).appendingPathExtension(str)
	}
	
	func stringByAppendingPathComponent(_ str: String) -> String {
		return (self as NSString).appendingPathComponent(str)
	}
	
	var stringByDeletingPathExtension: String {
		return (self as NSString).deletingPathExtension
	}

	var stringByDeletingLastPathComponent: String {
		return (self as NSString).deletingLastPathComponent
	}

	var stringByAbbreviatingWithTildeInPath: String {
		return (self as NSString).abbreviatingWithTildeInPath;
	}
	
	var stringByExpandingTildeInPath: String {
		return (self as NSString).expandingTildeInPath;
	}
	
	var lastPathComponent: String {
		return (self as NSString).lastPathComponent
	}

	var pathExtension: String {
		return (self as NSString).pathExtension
	}

	var pathComponents: [String] {
		return (self as NSString).pathComponents
	}

	func pathsForResourcesOfType(_ type: String) -> [String] {
		let enumerator = FileManager.default.enumerator(atPath: self)
		var filePaths = [String]()
		while let filePath = enumerator?.nextObject() as? String {
			if filePath.pathExtension == type {
				filePaths.append(filePath)
			}
		}
		return filePaths
	}

	var lines: [String] {
		var lines = [String]()
		self.enumerateLines { (line, stop) -> () in
			lines.append(line)
		}
		return lines
	}

	func indent() -> String {
		return self.lines.map{"  " + $0}.joined(separator: "\r")
	}

	func substringWithRange(_ range: NSRange) -> String {
		let subindex1 = self.characters.index(self.startIndex, offsetBy: range.location)
		let subindex2 = self.characters.index(subindex1, offsetBy: range.length)
		return self.substring(with: subindex1 ..< subindex2)
	}
	
	var data: Data {
		return self.data(using: String.Encoding.utf8)!
	}

}
