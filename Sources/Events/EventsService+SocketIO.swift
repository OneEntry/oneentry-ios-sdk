//
//  EventsService+SocketIO.swift
//  OneEntry
//
//  Created by Archibbald on 2/25/25.
//

import Foundation

@preconcurrency import SocketIO
@preconcurrency import OneEntryShared

extension EventsService {
    static let socketIO: SocketManager = {
        let configuration = OneEntryCore.shared.configuration
        let url = URL(string: "https://" + configuration.host)!
        let credential = configuration.credential
        var headers: [String: String] = [:]
        
        if let accessToken = AccessService.shared.accessToken {
            headers["Authorization"] = "Bearer \(accessToken)"
        }
        
        var config: SocketIOClientConfiguration = [
            .path("/api/content/ws"),
            .log(true),
            .forceWebsockets(true),
            .reconnects(true),
            .reconnectAttempts(5)
        ]
        
        switch credential {
            case let credential as TokenCredential:
                headers["x-app-token"] = credential.token
                
            case let credential as SocketDeledate.Credential:
                let delegate = SocketDeledate(credential: credential)
                config.insert(.sessionDelegate(delegate))
            
            default:
                break
        }
        
        config.insert(.extraHeaders(headers))
        
        return SocketManager(socketURL: url, config: config)
    }()
    
    public var notifications: AsyncThrowingStream<SocketEvent, Error> {
        AsyncThrowingStream { configuration in
            let socket = Self.socketIO.defaultSocket
                                                
            socket.on("notification") { data, ask in
                do {
                    guard let dictionary = data.first as? NSDictionary else { return }
                    
                    let data = try JSONSerialization.data(withJSONObject: dictionary)
                    
                    guard let json = String(data: data, encoding: .utf8) else { return }
                    
                    let event = try SocketEvent_NSDictionaryKt.SocketEvent(string: json)
                    
                    configuration.yield(event)
                } catch {
                    configuration.finish(throwing: error)
                }
            }
            
            socket.on(clientEvent: .disconnect) { _, _ in
                configuration.finish()
            }
            
            configuration.onTermination = { _ in
                socket.disconnect()
            }
            
            socket.connect()
        }
    }
}

fileprivate final class SocketDeledate: NSObject, URLSessionDelegate {
    typealias Credential = OneEntryShared.URLCredential
    
    let credential: Credential
    
    init(credential: Credential) {
        self.credential = credential
    }
    
    func urlSession(
        _ session: Foundation.URLSession,
        didReceive challenge: URLAuthenticationChallenge
    ) async -> (Foundation.URLSession.AuthChallengeDisposition, Foundation.URLCredential?) {
        (.useCredential, credential.urlCredential)
    }
}
