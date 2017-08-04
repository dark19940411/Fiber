//
//  FetchDownloadLink.swift
//  Fiber
//
//  Created by turtle on 2017/8/4.
//
//

import Foundation
import CommandLineKit

func fetchURLStr() -> String {
    let cli = CommandLineKit.CommandLine()
    
    let linkStr = StringOption(shortFlag: "l", longFlag: "link", required: true,
                               helpMessage: "Given URL for downloading.")
    
    cli.addOptions(linkStr)
    
    do {
        try cli.parse()
    } catch {
        cli.printUsage(error)
        exit(EX_USAGE)
    }
    
    return linkStr.value!
}
