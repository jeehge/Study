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

import Foundation

final class NetworkManager {
	private let disposeBag = DisposeBag()
	private var socket = WebSocket(url: URL(string: "wss://echo.websocket.org")!)
	private let writeSubject = PublishSubject<String>()
	
	static func request<T: Decodable>(api: API, parameters: [String: String], completion: @escaping (Result<[T], Error>) -> Void) {
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
						let result = try JSONDecoder().decode([T].self, from: responseData)
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
	
	func setup() {
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
