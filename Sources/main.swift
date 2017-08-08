import Foundation

func turnDestinationToFinalURL(_ fileName: String) -> String {    //路径解析，获取文件名
    let destination = result.destination
    let ndest = destination as NSString
    return ndest.appendingPathComponent(fileName)
}

let result = fetchCmdLineResult()
let link = result.link as NSString

guard let downloadURL = URL(string: result.link) else { fatalError("The download url is not valid.".red.bold) }

let fileName = link.lastPathComponent
let fullPath = turnDestinationToFinalURL(fileName)

let destURL = fullPath.turnToFileURL()

FiberDownload.default.startDownload(from: downloadURL, to: destURL)



