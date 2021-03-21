//
//  NetworkManager.swift
//  RxSwiftProject
//
//  Created by JH on 2021/03/01.
//

import UIKit
import Starscream
import RxSwift

class NetworkManager {
	private let disposeBag = DisposeBag()
	private var socket: WebSocket?
	private let writeSubject = PublishSubject<String>()
	
	static let shared = NetworkManager()
	
	private init() {
		var request = URLRequest(url: URL(string: "wss://api.upbit.com/websocket/v1")!)
		request.timeoutInterval = 5
		socket = WebSocket(request: request)
		socket?.delegate = self
	}
	
	deinit {
		socket?.disconnect()
	}
	
	static func request<T: Decodable>(api: API, parameters: [String: String], completion: @escaping (Result<T, Error>) -> Void) {
		guard let request: URLRequest = getFinalURL(api: api,
													parameters: parameters) else { return }
		URLSession.shared.dataTask(with: request) {(data, response, error) in
			DispatchQueue.main.async {
				if let error = error {
					completion(.failure(error))
				}
				
				guard let response = response as? HTTPURLResponse else { return }
				if (200..<300).contains(response.statusCode){
					guard let responseData = data else {
						completion(.failure(APIError.noData))
						return
					}
					
					do {
//						let response = try JSONSerialization.jsonObject(with: responseData, options: [])
//						print(response)
						let result = try JSONDecoder().decode(T.self, from: responseData)
						completion(.success(result))
					} catch {
						completion(.failure(APIError.parseError))
						return
					}
				} else {
					completion(.failure(APIError.errorCode(response.statusCode)))
				}
			}
		}.resume()
	}
	
	private static func getFinalURL(api: API,  parameters: [String: String]) -> URLRequest? {
		guard var components: URLComponents = URLComponents(string: api.path) else { return nil }
		components.setQueryItems(with: parameters)
		
		guard let url = components.url else { return nil }
		var request = URLRequest(url: url)
		request.httpMethod = api.method.rawValue
		return request
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

extension NetworkManager: WebSocketDelegate {
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
			break
		}
	}
}
