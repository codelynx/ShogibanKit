//
//  NSScanner+Z.swift
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
//

import Foundation


extension NSScanner {

	func scanString(string: String) -> String? {
		if self.scanString(string, intoString: nil) {
			return string
		}
		return nil
	}

	func scanEitherString(strings: [String]) -> String? {
		for string in strings {
			if self.scanString(string, intoString: nil) {
				return string
			}
		}
		return nil
	}

	func scanUpToString(string: String) -> String? {
		var outString: NSString? = nil
		if self.scanUpToString(string, intoString: &outString) {
			return outString as? String
		}
		return nil
	}

	func scanCharactersFromSet(set: NSCharacterSet) -> String? {
		var outString: NSString? = nil
		if self.scanCharactersFromSet(set, intoString: &outString) {
			return outString as? String
		}
		return nil
	}

	func scanUpToCharactersFromSet(set: NSCharacterSet) -> String? {
		var outString: NSString? = nil
		if self.scanUpToCharactersFromSet(set, intoString: &outString) {
			return outString as? String
		}
		return nil
	}

	func scanInt() -> Int? {
		var outValue: Int32 = 0
		if self.scanInt(&outValue) {
			return Int(outValue)
		}
		return nil
	}
	
	func scanFloat() -> Float? {
		var outValue: Float = 0.0
		if self.scanFloat(&outValue) {
			return outValue
		}
		return nil
	}
	
	func scan<T>(pattern: [String: T]) -> T? {
		for (key, value) in pattern {
			if self.scanString(key, intoString: nil) {
				return value
			}
		}
		return nil
	}
	
}