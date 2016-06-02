//
//  String+lines.swift
//  ZKit
//
//  Copyright (c) 2015 Kaz Yoshikawa.
//
//	This software may be modified and distributed under the terms of the MIT license.
//

import Foundation

extension String {

	func lines() -> [String] {
		var lines = [String]()
		self.enumerateLines { (line, stop) -> () in
			lines.append(line)
		}
		return lines
	}

}
