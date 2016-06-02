//
//  NSScanner+Z.swift
//  ZKit
//
//  Created by Kaz Yoshikawa on 6/2/16.
//
//	This software may be modified and distributed under the terms of the MIT license.
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
	
	
}