//
//	ExperimentViewController.swift
//  ShogibanKit
//
//	Copyright (c) 2016 Kaz Yoshikawa
//
//	This software may be modified and distributed under the terms
//	of the MIT license.  See the LICENSE file for details.
//
//

import Cocoa

class ExperimentViewController: NSViewController {

	@IBOutlet var textView: NSTextView!

	var font: NSFont {
		return NSFont(name: "SourceHanCodeJP-Regular", size: 12)!
	}

	var menuItem: (MenuItem)? {
		didSet {
			let string = self.menuItem?.1() ?? ""
			let attributes: [String: AnyObject] = [NSFontAttributeName: self.font]
			let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
			self.textView.textStorage?.setAttributedString(attributedString)
			
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
}
