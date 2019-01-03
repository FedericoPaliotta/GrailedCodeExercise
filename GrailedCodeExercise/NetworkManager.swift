//
//  NetworkManager.swift
//  GrailedCodeExercise
//
//  Created by Federico Paliotta on 12/17/18.
//  Copyright © 2018 me. All rights reserved.
//

import Foundation

protocol NetworkRequest: class {
  func cancel()
}

extension URLSessionTask : NetworkRequest { }

enum NetworkResult {
  
  case success(status: Int, data: Data)
  case failure(response: URLResponse?, statusCode: Int, error: Error?, message: String?)
  
}


final class NetworkManager {
  
  private init() { }
  static let shared = NetworkManager()
  
  /// - Note: completion handlers passed to this function are
  ///         guaranteed to be executed on the main thread.
  @discardableResult
  func send(_ request: URLRequest,
            completion: @escaping (NetworkResult)->Void) -> NetworkRequest?
  {
    let dataTask = URLSession.shared.dataTask(with: request)
    { maybeData, response, error in
      self.handleNetworkResponse(maybeData: maybeData,
                                 response: response,
                                 error: error,
                                 completion: completion)
    }
    dataTask.resume()
    return dataTask
  }
  
  private func handleNetworkResponse(maybeData: Data?,
                                     response: URLResponse?,
                                     error: Error?,
                                     completion: (@escaping (NetworkResult) -> Void))
  {
    guard let httpResponse = response as? HTTPURLResponse else {
      /// - Note: for example a request did timeout
      completion(.failure(response: response, statusCode: -1,
                          error: error, message: "Invalid HTTPURLResponse"))
      return
    }
    guard error == nil else {
      completion(.failure(response: response, statusCode: -1,
                          error: error, message: "Unexpected Error"))
      return
    }
    let statusCode = httpResponse.statusCode
    
    guard statusCode < 400 else {
      let errorMessage = statusCode < 500 ? "Bad Request" : "Server Error"
      completion(.failure(response: response, statusCode: statusCode,
                          error: error, message: errorMessage))
      return
    }
    
    guard let data = maybeData else {
      completion(.failure(response: response, statusCode: statusCode,
                          error: error, message: "Null Data"))
      return
    }
    completion(.success(status: statusCode, data: data))
  }
}
