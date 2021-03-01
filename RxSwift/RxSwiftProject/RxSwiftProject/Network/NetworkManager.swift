//
//  NetworkManager.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/01.
//

import UIKit
import Starscream
import RxStarscream
import RxSwift


final class NetworkManager {
	static let shared = NetworkManager()
	
	private let disposeBag = DisposeBag()
	private var socket = WebSocket(url: URL(string: "wss://echo.websocket.org")!)
	private let writeSubject = PublishSubject<String>()
	
	private init() {
		setup()
	}
	
	private func setup() {
		socket = WebSocket(url: URL(string: "ws://localhost:8080/")!)
		socket.connect()
	}
	
	func disconnent() {
		socket.disconnect(forceTimeout: 0)
		socket.delegate = nil
	}
}

extension NetworkManager: WebSocketDelegate {
	func websocketDidConnect(socket: WebSocketClient) {
		//
	}
	
	func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
		//
	}
	
	func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
		//
	}
	
	func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
		//
	}
	
	
}
