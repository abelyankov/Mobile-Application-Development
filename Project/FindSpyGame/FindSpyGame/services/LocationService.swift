//
//  LocationService.swift
//  FindSpyGame
//
//  Created by Arthur Belyankov on 5/13/19.
//  Copyright © 2019 Arthur Belyankov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LocationService {
    static func getLocationList(success: @escaping ([Location]) -> Void,failure: @escaping (Error) -> Void){
        let url = URL.init(string: "http://127.0.0.1:8000/")
        let contentHeaders: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        Alamofire.request(url!,
                          parameters: nil,
                          headers: contentHeaders)
            .responseJSON { responce in
                switch responce.result{
                case .success(let val):
                    let locations = JSON(val)["locations"].arrayValue
                    var res = [Location]()
                    for json in locations{
                        res.append(Location.init(json: json))
                    }
                    success(res)
                case .failure(let error):
                    failure(error)
                }
        }
        
    }
}
