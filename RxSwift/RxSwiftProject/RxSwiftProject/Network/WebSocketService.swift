//
//  WebSocketService.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/22.
//

import Foundation
import RxSwift
import RxCocoa
import Starscream

final class WebSocketService {
	static let shared = WebSocketService()
	
	private var socket: WebSocket?
	private let disposeBag = DisposeBag()
	
	init() {
		var request = URLRequest(url: URL(string: "wss://api.upbit.com/websocket/v1")!)
		request.timeoutInterval = 5
		socket = WebSocket(request: request)
		socket?.delegate = self
	}
	
	deinit {
		print("WebSocketService deinit")
		socket?.disconnect()
	}
	
	func connect() {
		socket?.connect()
		print("web socket start")
	}
	
	func write(message: String) {
		if let data = message.data(using: .utf8) {
			socket?.write(data: data)
		}
	}
	 
	func disconnect() {
		socket?.disconnect()
	}
}

extension WebSocketService: WebSocketDelegate {
	func didReceive(event: WebSocketEvent, client: WebSocket) {
		switch event {
		case .connected(let headers):
			print("websocket is connected: \(headers)")
		case .disconnected(let reason, let code):
			print("websocket is disconnected: \(reason) with code: \(code)")
		case .text(let string):
			print("Received text: \(string)")
		case .binary(let data):
			let response = try? JSONSerialization.jsonObject(with: data, options: [])
			print(response)
		case .ping(_):
			break
		case .pong(_):
			break
		case .viabilityChanged(_):
			break
		case .reconnectSuggested(_):
			break
		case .cancelled:
			break
		case .error(let error):
			print(error?.localizedDescription)
		}
	}
}

