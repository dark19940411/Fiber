//
//  FiberDownload.swift
//  Fiber
//
//  Created by turtle on 2017/8/7.
//
//

import Foundation
import Alamofire
import Progress

class FiberDownload {
    /// Singleton of FiberDownload
    static let `default` = FiberDownload()
    
    /// A semaphore to avoid this script being terminated from asynchronous task
    fileprivate let sema = DispatchSemaphore(value: 0)
    /// Because the actual applying queue of Alamorefire can't be got, and the main queue is blocked by semaphore while the downloading task is executing, FiberDownload has to possess its own queue to handle call-back
    fileprivate let handlerQueue = DispatchQueue(label: "com.turtle.Fiber.downloadHandlerQueue")
    /// The progress bar of Fiber
    fileprivate var bar = ProgressBar(count: 101, configuration: [ProgressPercent(), ProgressBarLine(barLength: 60)])
    
    /// A downloaded count down(percentage), which is in [0, 100] (mathematic interval)
    fileprivate var currentProgress: Int = 0
    
    
    fileprivate init() {}
    
    /// Start download job with a sourceURL and a Destination URL
    ///
    /// - Parameters:
    ///   - sourceURL: The URL stands for the resources' place
    ///   - destURL: The URL stands for the place where downloaded file to be
    public func startDownload(from sourceURL: URL, to destURL: URL) {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (destURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let downloadRequest = Alamofire.download(sourceURL, to: destination)
        
        downloadRequest.response(queue: handlerQueue) { response in
            if response.error == nil, let resource = response.destinationURL?.path {
                
            }
            
            self.sema.signal()
        }
        
        downloadRequest.downloadProgress(queue: handlerQueue) { progress in
            self.updateProgressBar(with: progress.fractionCompleted)
        }
        bar.next()
        
        sema.wait()
    }
    
    fileprivate func updateProgressBar(with progress: Double) {
        
        let downloadedFrac = Int(floor(progress * 100))
        let progressSubstract = downloadedFrac - currentProgress
        print("progress: \(progress)\n downloadedFrac: \(downloadedFrac)\ncurrentProgress: \(currentProgress)")
        
        for _ in 0..<progressSubstract {
            bar.next()
            currentProgress = downloadedFrac
        }
    }
}
