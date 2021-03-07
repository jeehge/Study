//
//  BaseViewController.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/01.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController, ViewControllerFromStoryBoard {
	
	var disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		bind()
	}
	
	func setup() {}
	
	func bind() {}
}
