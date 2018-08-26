//
//  RequestSender.swift
//  Job
//
//  Created by Oleg Shupulin on 14.08.2018.
//  Copyright © 2018 Oleg Shupulin. All rights reserved.
//

import Foundation


typealias NetworkCompletionHandler<T> = (Result<T>) -> Void

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol IRequestSender {
    func send<Parser>(config: RequestConfig<Parser>,
                      completionHandler: NetworkCompletionHandler<Parser.Model>?)
}

final class RequestSender: IRequestSender {
    
    let session = URLSession(configuration: .default)
    
    func send<Parser>(config: RequestConfig<Parser>,
                      completionHandler: NetworkCompletionHandler<Parser.Model>?) {
        
        guard let urlRequest = config.request.urlRequest else {
            completionHandler?(.failure(CustomErrorType.unknown))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler?(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler?(.failure(CustomErrorType.parseData))
                return
            }
            
            do {
                let parsedModel = try config.parser.parse(data: data)
                completionHandler?(.success(parsedModel))
            } catch {
                completionHandler?(.failure(error))
            }
        }
        task.resume()
    }
}
