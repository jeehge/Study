//
//  BaseViewController.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/01.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController: UIViewController, ViewControllerFromStoryBoard {
	// MARK: - Properties
	let disposeBag: DisposeBag = DisposeBag()

}
