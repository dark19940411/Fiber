//
//  FetchCommandLineParameters.swift
//  Fiber
//
//  Created by turtle on 2017/8/8.
//
//

import Foundation
import CommandLineKit
import Rainbow

struct CommandLineResult {
    /// return the download link user types in shell
    public let link:String
    /// return the path where the downloaded file saves
    public let destination:String
    
    fileprivate init(link: String, destination: String) {
        self.link = link
        self.destination = destination
    }
}

func fetchCmdLineResult() -> CommandLineResult {
    let cli = CommandLineKit.CommandLine()
    
    cli.formatOutput = { s, type in
        var str: String
        switch type {
        case .error:
            str = s.red.bold
        case .optionHelp:
            str = s.green
        case .optionFlag:
            str = s.blue
        default:
            str = s
        }
        return cli.defaultFormat(s: str, type: type)
    }
    
    let linkStr = StringOption(shortFlag: "l", longFlag: "link", required: true,
                               helpMessage: "Given URL for downloading.")
    let dest = StringOption(shortFlag: "d", longFlag: "destination", required: false, helpMessage: "Optional. Use it to configure your specific downloaded file saved path")
    
    cli.addOptions(linkStr, dest)
    
    do {
        try cli.parse()
    } catch {
        cli.printUsage(error)
        exit(EX_USAGE)
    }
    
    return CommandLineResult(link: linkStr.value!, destination: dest.value ?? FileManager.default.currentDirectoryPath )
}

