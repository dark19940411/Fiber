import Foundation
import CommandLineKit

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

print("File path is \(linkStr.value!)")
