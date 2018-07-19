//
//  ShogibanKit_ios_Tests.swift
//  ShogibanKit_ios_Tests
//
//  Created by Kaz Yoshikawa on 7/19/18.
//  Copyright © 2018 Kaz Yoshikawa. All rights reserved.
//

import XCTest
import ShogibanKit_ios

class ShogibanKit_ios_Tests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func test1() {
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
		XCTAssertTrue(局面.詰みか)
	}
	
	func testSamples() {
		for (局面, 詰) in self.samples {
			let checkmate = 局面.詰みか
			if checkmate != 詰 {
				print("\(局面)")
				print("computed checkmate=\(checkmate), expected=\(詰)")
			}
			XCTAssertTrue(checkmate == 詰)
		}
	}
	
	func testPerformanceExample() {
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}
	
	var samples: [(局面: 局面型, 詰: Bool)] = [
		(局面型(string:
			"後手持駒:歩5,香,銀,金,角\r" +
				"|▽香|▽桂|　　|▲竜|　　|　　|　　|　　|　　|\r" +
				"|　　|　　|　　|　　|　　|　　|　　|▲と|　　|\r" +
				"|▽歩|　　|▽歩|▽銀|▽歩|　　|▲竜|　　|　　|\r" +
				"|　　|　　|▽桂|　　|　　|　　|　　|▽歩|　　|\r" +
				"|▲歩|▽王|▲金|　　|　　|　　|▲歩|▽銀|　　|\r" +
				"|　　|　　|▲歩|　　|▲歩|　　|　　|　　|　　|\r" +
				"|　　|▲歩|　　|▲歩|　　|▲金|　　|　　|　　|\r" +
				"|　　|　　|　　|▲銀|　　|　　|　　|▽と|　　|\r" +
				"|▲香|▲桂|　　|▲金|　　|　　|▽飛|　　|　　|\r" +
			"先手持駒:桂,香,歩2", 手番: .後手)!, true),
		
		(局面型(string:
			"後手持駒:歩2,香2,銀\r" +
				"|　　|　　|　　|　　|　　|　　|　　|▲と|　　|\r" +
				"|　　|　　|　　|　　|　　|　　|　　|　　|▲金|\r" +
				"|　　|　　|　　|　　|　　|▽歩|▲竜|　　|　　|\r" +
				"|▽歩|　　|　　|　　|▽銀|　　|▽歩|▽金|▽王|\r" +
				"|　　|　　|▽銀|　　|▽桂|　　|　　|▽歩|▽歩|\r" +
				"|　　|▽香|　　|▲歩|▲桂|▲歩|　　|　　|　　|\r" +
				"|　　|▽金|▲歩|　　|▲歩|　　|　　|▽馬|　　|\r" +
				"|　　|　　|　　|▲桂|▲銀|　　|　　|▽竜|　　|\r" +
				"|　　|　　|▲玉|▲金|　　|　　|　　|▽圭|　　|\r" +
			"先手持駒:歩6,桂,角", 手番: .後手)!, false),
		
		(局面型(string:
			"後手持駒:歩2,香2,銀\r" +
				"|　　|　　|　　|　　|　　|　　|　　|▲と|　　|\r" +
				"|　　|　　|　　|　　|　　|　　|　　|　　|▲金|\r" +
				"|　　|　　|　　|　　|　　|▽歩|▲竜|　　|　　|\r" +
				"|▽歩|　　|　　|　　|▽銀|　　|▽歩|▽金|▽王|\r" +
				"|　　|　　|▽銀|　　|▽桂|　　|　　|▽歩|▽歩|\r" +
				"|　　|▽香|　　|▲歩|▲桂|▲歩|　　|　　|　　|\r" +
				"|　　|　　|▲歩|　　|▲歩|　　|　　|▽馬|　　|\r" +
				"|　　|▽金|　　|▲桂|▲銀|　　|　　|▽竜|　　|\r" +
				"|　　|　　|▲玉|▲金|　　|　　|　　|▽圭|　　|\r" +
			"先手持駒:歩6,桂,角", 手番: .先手)!, true),
		

		/*	COPY & PASTE TEMPLATE

		//	[▽歩, ▽香, ▽桂, ▽銀, ▽金, ▽角, ▽飛, ▽王, ▽と, ▽杏, ▽圭, ▽全, ▽馬, ▽竜]
		//	[▲歩, ▲香, ▲桂, ▲銀, ▲金, ▲角, ▲飛, ▲玉, ▲と, ▲杏, ▲圭, ▲全, ▲馬, ▲竜]
		
		(局面型(string:
		"後手持駒:歩2,香,桂,銀,金,角,飛\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"|　　|　　|　　|　　|　　|　　|　　|　　|　　|\r" +
		"先手持駒:歩2,香,桂,銀,金,角,飛", 手番: .先手)!, true),
		*/
		
		]
	
	
}
