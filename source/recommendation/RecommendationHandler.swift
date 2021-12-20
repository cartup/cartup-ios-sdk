//
//  EventHandler.swift
//  test
//
//  Created by Arvind Rapaka on 8/21/21.
//

import Foundation

public class RecommendationHandler {
    var orgname: String
    var orgid: String
    var secretkey: String
    var domain: String
    var params = RecommendationsParams()
    let udf: UDFS
    let sessionId: String
    let queue = DispatchQueue(label: "queue.operations", attributes: .concurrent)
    enum HTTP {
        enum Error: LocalizedError {
            case invalidResponse
            case badStatusCode
            case missingData
        }
    }
    
    public init(_ orgname: String, _ orgid: String, _ secretkey: String, _ domain: String) {
        self.orgid = orgid
        self.secretkey = secretkey
        self.orgname = orgname
        self.domain = domain
        self.sessionId = UUID().uuidString
        let iParams: Dictionary<String, Any> = ["orgname": orgname, "orgid": orgid,
                                                "secretkey": secretkey, "domain": domain, "sessionId": sessionId]
        self.udf = UDFS(initParams: iParams)
        
    }
    
    public func createURLRequest(eventAttributes: Dictionary<String,[Any]>,
                              parameters:Dictionary<String, Any>) -> URLComponents {

        
        var urlComponent = URLComponents()
        urlComponent.scheme = (reco_params["server"] as! Dictionary<String, Any>)["scheme"] as? String
        urlComponent.host = (reco_params["server"] as! Dictionary<String, Any>)["host"] as? String
        urlComponent.path = (reco_params["server"] as! Dictionary<String, Any>)["path"] as! String
        
        var queryItems = [URLQueryItem]()
        for (paramKey, pAttributes) in eventAttributes {
            
            let value = udf.eval(pAttributes[1] as! String, parameters, pAttributes)
            if let str = value as? String {
                if str == "" {
                    continue
                }
                queryItems.append(URLQueryItem(name: paramKey, value: value as? String))
            }
            else if let intvalue = value as? Int {
                queryItems.append(URLQueryItem(name: paramKey, value: String(intvalue)))
            }
            else if let intvalue = value as? Float {
                queryItems.append(URLQueryItem(name: paramKey, value: String(intvalue)))
            }
        }
        urlComponent.queryItems = queryItems
        return urlComponent
    }
    
    public func getRecommendations(parameters:Dictionary<String, Any>,
                                   _ completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) throws {
        let eventAttributes: Dictionary<String,[Any]> = params.getevent()!
        var missingParams = [String]()
        for (pkey, pAttributes ) in eventAttributes {
            if pAttributes[0] as? Int == 1 && !parameters.keys.contains(pkey) {
                missingParams.append(pkey)
            }
        }
        if (missingParams.count > 0) {
            throw MyError.runtimeError("Missing Paramters : " + missingParams.joined(separator:", "))
        }
        let urlComponent = createURLRequest(eventAttributes: eventAttributes, parameters: parameters)
        print(urlComponent)
        postRequest(urlComponent, completion)
    }
 
    public func postRequest(_ urlComponent: URLComponents,
                            _ completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
        let url = urlComponent.url!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                return completion(.failure(error!))
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return completion(.failure(HTTP.Error.invalidResponse))
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return completion(.failure(HTTP.Error.badStatusCode))
            }
            do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
            } catch {
                    print("JSON error: \(error.localizedDescription)")
            }

            return completion(.success((data!, response)))
            
        }.resume()
    }
}


