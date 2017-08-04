import Foundation
import Alamofire

let downloadLink = fetchURLStr()

Alamofire.download(downloadLink).responseData { response in
    if let data = response.result.value {
        
    }
}
