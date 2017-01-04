//
//	MenuTableViewController.swift
//  ShogibanKit
//
//	Copyright (c) 2016 Kaz Yoshikawa
//
//	This software may be modified and distributed under the terms
//	of the MIT license.  See the LICENSE file for details.


import Cocoa

typealias MenuItem = (title: String, closure: (() -> String))


protocol MenuTableViewControllerDelegate: class {
	func menuTableViewController(_ menuTableViewController: MenuTableViewController, didSelectItem: MenuItem?)
}



class MenuTableViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

	@IBOutlet weak var tableView: NSTableView!
	weak var delegate: MenuTableViewControllerDelegate?

	lazy var menuItems: [MenuItem] = [
		(title: "ランダム対戦1", closure: self.ランダム対戦1),
		(title: "詰みの判定2", closure: self.詰みの判定1),

	]

	let ランダム対戦1: (() -> String) = {
		var count = 0
		var string = ""
		var 局面: 局面型? = 手合割型.平手.初期局面
		print("\(局面)")
		while let 当該局面 = 局面 , count <= 200 {
			defer { count += 1 }
			let 王手列 = 当該局面.王手列(当該局面.手番.敵方)
			if let 王手 = 王手列.first {
				局面 = 当該局面.指手を実行(王手).次局面
			}
			else if let 全指手 = 局面?.全可能指手列 {
				string += "全可能指手: " + 全指手.map { $0.description }.joined(separator: ", ") + "\r"
				//print("全可能指手: " + 全指手.map { $0.description }.joinWithSeparator(", "))
				let 指手 = 全指手[Int(arc4random_uniform(UInt32(全指手.count)))]
				print("\(指手)")
				string += "指手: \(指手)" + "\r"
				局面 = 当該局面.指手を実行(指手).次局面
				string += (局面?.description ?? "") + "\r-----\r"
				print("\(局面)")
				print("----------")
			}
		}
		return string
	}

	let 詰みの判定1: (() -> String) = {
		var string = ""
		let 局面 = 局面型(string:
			"後手持駒:桂\r" +
			"|▽香|▲竜|　　|　　|　　|　　|　　|　　|▽香|\r" +
			"|　　|　　|▲金|　　|▲竜|　　|　　|　　|　　|\r" +
			"|▽歩|▲全|　　|　　|▽金|　　|▽歩|▽桂|▽歩|\r" +
			"|　　|▽歩|　　|　　|▽王|　　|▽銀|　　|　　|\r" +
			"|　　|　　|　　|▲金|▲角|　　|　　|　　|　　|\r" +
			"|　　|　　|▽香|▲歩|▲歩|▲銀|▲桂|　　|　　|\r" +
			"|▲歩|▲歩|　　|　　|　　|▲歩|▲銀|　　|▲歩|\r" +
			"|　　|　　|　　|▲金|　　|　　|　　|▲歩|　　|\r" +
			"|▲香|　　|　　|▲玉|　　|　　|　　|▽馬|　　|\r" +
			"先手持駒:桂,歩7", 手番: .後手)!
		print("\(局面)")
		string += "\(局面)"
		let 詰み = 局面.詰みか
		string += "詰み: \(詰み)"
		return string
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	func numberOfRows(in tableView: NSTableView) -> Int {
		return menuItems.count
	}

	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		switch (tableColumn?.identifier ?? "") {
		case "title":
			let item = self.menuItems[row]
			print("hellow world!!")
			let view = tableView.make(withIdentifier: "cell", owner: nil) as! NSTableCellView
			view.textField!.stringValue = item.0
//			view.imageView?.image = NSImage(named: )
			assert(view.textField != nil)
			return view
		default: break
		}
		return nil
	}

	func tableViewSelectionDidChange(_ notification: Notification) {
		if self.tableView.selectedRow >= 0 {
			self.delegate?.menuTableViewController(self, didSelectItem: menuItems[self.tableView.selectedRow])
		}
		else {
			self.delegate?.menuTableViewController(self, didSelectItem: nil)
		}
	}

	
}
