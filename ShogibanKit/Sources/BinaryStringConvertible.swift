//
//	BinaryStringConvertible.swift
//	ZKit
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


public protocol BinaryStringConvertible: UnsignedInteger {

	var binaryString: String { get }
	init?(binaryString: String)

}

extension BinaryStringConvertible {

	public var binaryString: String {
		var value = self
		let bitlength = MemoryLayout<Self>.size * 8
		var string = ""
		for _ in (0 ..< bitlength) {
			string = ((value % 2 == 0) ? "0" : "1") + string
			value = value / 2
		}
		return string
	}

	public init?(binaryString: String) {
		let bitLength = MemoryLayout<Self>.size * 8
		var bitCount = 0
		var value: Self = 0
		for ch in binaryString {
			switch ch {
			case "0":
				value = (value * 2) + 0
				bitCount += 1
			case "1":
				value = (value * 2) + 1
				bitCount += 1
			default:
				break
			}
			if bitCount >= bitLength {
				self = value
				return
			}
		}
		return nil
	}

}

extension UInt8: BinaryStringConvertible {
}

extension UInt16: BinaryStringConvertible {
}

extension UInt32: BinaryStringConvertible {
}

extension UInt64: BinaryStringConvertible {
}
