//
//  BaseViewController.swift
//  EcommerceGapsi
//
//  Created by Arlen Peña on 21/06/21.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    var path = Constants.URL_RESOURCES_APP
    
    enum NetworkError: Error {
        case url
        case server
    }
    
    public func getDataFromREST()->Result<String?,NetworkError>{
       // let path = Constants.URL_RESOURCES_APP
       
        guard let url = URL(string: path) else {
            return .failure(.url)
        }
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "GET"
        request.setValue("adb8204d-d574-4394-8c1a-53226a40876e", forHTTPHeaderField: "X-IBM-Client-Id")
        var result: Result<String?, NetworkError>!
        
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request){ (data, _, _) in
            if let data = data {
                result = .success(String(data: data, encoding: .utf8))
            } else {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()
        _ = semaphore.wait(wallTimeout: .distantFuture)
        return result
    }
}


