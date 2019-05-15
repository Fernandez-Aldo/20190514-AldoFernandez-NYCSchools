//
//  SchoolAPIClient.swift
//  NYCSchools
//
//  Created by MAC Consultant on 05/14/19.
//  Copyright © 2019 Aldo. All rights reserved.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

protocol SchoolAPIClient {
    func retrieveSchools(completion: @escaping ([School]?) -> ())
    func retrieveSATSchools(completion: @escaping ([School]?) -> ())
}

protocol URLSessionProtocol {
    func dataTask(with: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

class NYCSchoolAPIClient : SchoolAPIClient {
    
    var session: URLSessionProtocol
    
    init(aSession: URLSessionProtocol = URLSession.shared) {
        session = aSession
    }
    //get schoools from the endpoint
    func retrieveSchools(completion: @escaping ([School]?) -> ()) {
        let url = URL(string: SCHOOLS_RESOUCE)
        session.dataTask(with: url!) { data, URLResponse, Error in
            if Error != nil {
                print(Error.debugDescription)
            }
            let decoder = JSONDecoder()
            let listOfSchools = try! decoder.decode([School].self, from: data!)
            DispatchQueue.main.async {
                completion(listOfSchools)
            }
        }.resume()
    }
    // get SAT school's results
    func retrieveSATSchools(completion: @escaping ([School]?) -> ()) {
        SchoolSATService.sharedInstance().retrieveSAT { (schools) in
            DispatchQueue.main.async {
                completion(schools)
            }
        }
        /*
        let url = URL(string: "https://data.cityofnewyork.us/resource/734v-jeq5.json")
        session.dataTask(with: url!) { data, URLResponse, Error in
            if Error != nil {
                print(Error.debugDescription)
            }
            let decoder = JSONDecoder()
            let listOfSchools = try! decoder.decode([School].self, from: data!)
            DispatchQueue.main.async {
                completion(listOfSchools)
            }
        }.resume()
 */
    }
}

extension URLSession : URLSessionProtocol { }
