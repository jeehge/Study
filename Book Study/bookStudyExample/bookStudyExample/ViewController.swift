//
//  ViewController.swift
//  bookStudyExample
//
//  Created by JH on 2021/05/25.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let menu: Menu = Menu(items: [ MenuItem(name: "아메리카노", price: 1500),
									   MenuItem(name: "카푸치노", price: 2000),
									   MenuItem(name: "카라멜 마키아또", price: 2500),
									   MenuItem(name: "에스프레소", price: 2500) ] )
		
		let barista = Barista()
		
		let 졔 = Customer()
		졔.order(menuName: "아메리카노", menu: menu, barista: barista)
	}
}

/**
Customer는 Menu에게 menuName에 해당하는 MenuItem을 찾아달라고 요청
MenuItem을 받아 이를 Barista에게 전ㄷ날해서 원하는 커피를 제조하도록 요청해야 한다
*/

class Customer {
	// Customer의 order() 메서드의 인자로 menu와 barista 객체를 전달받는 방법으로 참조 문제 해결
	func order(menuName: String, menu: Menu, barista: Barista) {
		guard let menuItem: MenuItem = menu.chosse(menuName: menuName) else { return }
		let coffee: Coffee = barista.makeCoffee(menuItem: menuItem)
		print(coffee.outCoffee())
	}
}

class MenuItem {
	private var name: String
	private var price: Int
	
	init(name: String, price: Int) {
		self.name = name
		self.price = price
	}
	
	func cost() -> Int {
		return price
	}
	
	func getName() -> String {
		return name
	}
}

// Menu는 menuName에 해당하는 MenuItem을 찾아야 하는 책임이 있다
// 이 책임을 수행하기 위해서는 Menu가 내부적으로 MenuItem을 관리하고 있어야 한다
// 간단하게 Menu가 MenuItem의 목록을 포함시키자
class Menu {
	private var items: [MenuItem] = []
	
	init(items: [MenuItem]) {
		self.items = items
	}
	
	// MenuItem의 목록을 하나씩 검사해가면서 이름이 동일한 MenuItem을 찾아 반환
	func chosse(menuName: String) -> MenuItem? {
		return items.filter { $0.getName() == menuName }.first
	}
}

// MenuItem을 이용해서 커피 제조
class Barista {
	func makeCoffee(menuItem: MenuItem) -> Coffee {
		let coffee: Coffee = Coffee(menuItem: menuItem)
		return coffee
	}
}

class Coffee {
	private var name: String
	private var price: Int
	
	// 자기 자싱늘 생성하기 위해 생성자 제공
	init(menuItem: MenuItem) {
		self.name = menuItem.getName()
		self.price = menuItem.cost()
	}
	
	func outCoffee() -> String {
		return "고객님 주문하신 \(name) 나왔습니다. 가격은 \(price) 입니다."
	}
}
