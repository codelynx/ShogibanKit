//
//	NSData+binaryString.swift
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


extension Data {

	public var binaryString: String {
		var bitString = ""
		self.forEach {
			var string = ""
			var byte  = $0
			for _ in (0 ..< 8) {
				string = ((byte % 2 == 0) ? "0" : "1") + string
				byte = byte / 2
			}
			bitString += string
		}
		return bitString
	}

	public init(binaryString: String) {
		var buffer = [UInt8]()
		var bitIndex = UInt8(0)
		var byte: UInt8 = 0
		for ch in binaryString.characters {
			switch ch {
			case "0":
				byte = (byte << 1) + 0
				bitIndex += 1
			case "1":
				byte = (byte << 1) + 1
				bitIndex += 1
			default: break
			}
			if bitIndex >= 8 {
				buffer.append(byte)
				byte = 0
				bitIndex = 0
			}
		}
		if bitIndex > 0 {
			byte = (byte << (8 - bitIndex))
			buffer.append(byte)
		}
		self.init(bytes: buffer)
	}

}

