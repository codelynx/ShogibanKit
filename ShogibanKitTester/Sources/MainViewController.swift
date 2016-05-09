//
//  ViewController.swift
//  ShogibanKit
//
//	Copyright (c) 2016 Kaz Yoshikawa
//
//	This software may be modified and distributed under the terms
//	of the MIT license.  See the LICENSE file for details.
//
//

import Cocoa

class MainViewController: NSSplitViewController, MenuTableViewControllerDelegate {

	@IBOutlet weak var menuItem: NSSplitViewItem!
	@IBOutlet weak var experimentItem: NSSplitViewItem!

	lazy var menuTableViewController: MenuTableViewController = {
		return self.menuItem.viewController as! MenuTableViewController
	}()

	lazy var experimentViewController: ExperimentViewController = {
		return self.experimentItem.viewController as! ExperimentViewController
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.menuTableViewController.delegate = self
	}

	override var representedObject: AnyObject? {
		didSet {
		}
	}

	func menuTableViewController(menuTableViewController: MenuTableViewController, didSelectItem menuItem: MenuItem?) {
		self.experimentViewController.menuItem = menuItem
	}

}

