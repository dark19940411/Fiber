import Foundation
import Alamofire

func turnDestinationToFinalURL(_ fileName: String) -> String {    //路径解析，获取文件名
    let destination = result.destination
    let ndest = destination as NSString
    return ndest.appendingPathComponent(fileName)
}

let result = fetchCmdLineResult()
let link = result.link as NSString
guard let downloadURL = URL(string: result.link) else { fatalError("The download url is not valid.") }

let fileName = link.lastPathComponent
let fullPath = turnDestinationToFinalURL(fileName)

if let url = URL(string: fullPath), url.isFileURL {    //目标url合法，才开始下载
    let destination: DownloadRequest.DownloadFileDestination = { _, _ in
        return (URL(string: fullPath)!, [.removePreviousFile, .createIntermediateDirectories])
    }
    
    Alamofire.download(downloadURL, to: destination).response(completionHandler: { response in
        if response.error == nil, let imagePath = response.destinationURL?.path {
                
        }
    })
} else {                //目标url不合法，则给出提示
    print("This is not a valid destination.")
}


