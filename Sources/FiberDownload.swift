//
//  FiberDownload.swift
//  Fiber
//
//  Created by turtle on 2017/8/7.
//
//

import Foundation
import Alamofire

struct FiberDownload {
    /// Singleton of FiberDownload
    static let `default` = FiberDownload()
    
    fileprivate let sema = DispatchSemaphore(value: 0)
    fileprivate let handlerQueue = DispatchQueue(label: "com.turtle.Fiber.downloadHandlerQueue")
    
    fileprivate init() {
        
    }
    
    public func startDownload(from sourceURL: URL, to destURL: URL) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (destURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let downloadRequest = Alamofire.download(sourceURL, to: destination)
        
        downloadRequest.response(queue: handlerQueue) { response in
            print(response)
            //            if response.error == nil, let resource = response.destinationURL?.path {
            //
            //            }
            
            self.sema.signal()
        }
        
        downloadRequest.downloadProgress(queue: handlerQueue) { progress in
            print("progress: \(progress.completedUnitCount / progress.totalUnitCount)")
        }
        
        sema.wait()
    }
}
