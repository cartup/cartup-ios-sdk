//
//  EventHandler.swift
//  test
//
//  Created by Arvind Rapaka on 8/21/21.
//

import Foundation


public class EventHandler {
   
    var orgname: String
    var orgid: String
    var secretkey: String
    var domain: String
    var queue = Queue<String>()
    var events = Events()
    let udf: UDFS
    let sessionId: String
    
    struct Queue<T> {
        enum HTTP {
            enum Error: LocalizedError {
                case invalidResponse
                case badStatusCode
                case missingData
            }
        }
        
        private let queue = DispatchQueue(label: "queue.operations", qos: .background, attributes: .concurrent)
        private var elements: [T] = []

        mutating func enqueue(_ value: T) {
            queue.sync(flags: .barrier) {
                self.elements.append(value)
            }
        }
        
        mutating func dequeue() -> T? {
            guard !self.elements.isEmpty else {
                return nil
            }
            return self.elements.removeFirst()
            
        }


        mutating func postRequest(_ payload: T, _ completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {
            //let sema = DispatchSemaphore( value: 0 )
            var urlComponent = URLComponents()
            urlComponent.scheme = (event_params["server"] as! Dictionary<String, Any>)["scheme"] as? String
            urlComponent.host = (event_params["server"] as! Dictionary<String, Any>)["host"] as? String
            urlComponent.path = (event_params["server"] as! Dictionary<String, Any>)["path"] as! String
            
            
            urlComponent.queryItems = [
                URLQueryItem(name: "type", value: "clickstream"),
                URLQueryItem(name: "action", value: "push"),
                URLQueryItem(name: "inputJson", value: payload as? String)
            ]
            
            let url = urlComponent.url!
            print (url)
            
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
            //sema.wait()
        }
        
        func completion(_ result: Result<(Data, URLResponse), Error>) -> Void{
            print("Event Sent ...")
        }
        
        
        mutating func sendEvent() -> Void {
            return queue.sync(flags: .barrier) {
                while(true) {
                    let payload = dequeue()
                    if (payload == nil) {
                        break
                    }
                    postRequest(payload!, completion)
                }
            }
        }
        
        var head: T? {
            return queue.sync {
                return elements.first
            }
        }

        var tail: T? {
            return queue.sync {
                return elements.last
            }
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
    
    public func fillProperties(params: inout [String: [String: Any]],
                               paramKey: String, value: Any, field: String) -> Bool {
        if paramKey.hasSuffix("_s") {
            let prop:[String:Any] = ["value": value, "type": "string"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_d") {
            let prop:[String:Any] = ["value": value, "type": "double"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_l") {
            let prop:[String:Any] = ["value": value, "type": "long"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_i") {
            let prop:[String:Any] = ["value": value, "type": "int"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_dt") {
            let prop:[String:Any] = ["value": value, "type": "ISO_DATE"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_b") {
            let prop:[String:Any] = ["value": value , "type": "boolean"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_ss") {
            let prop:[String:Any] = ["value": value  , "type": "array", "element_type": "string"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_is") {
            let prop:[String:Any] = ["value": value , "type": "array", "element_type": "int"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_ds") {
            let prop:[String:Any] = ["value": value , "type": "array", "element_type": "double"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_ls") {
            let prop:[String:Any] = ["value": value , "type": "array", "element_type": "long"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_bs") {
            let prop:[String:Any] = ["value": value , "type": "array", "element_type": "boolean"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_dts") {
            let prop:[String:Any] = ["value": value , "type": "array", "element_type": "date"]
            params.updateValue(prop, forKey: field)
        } else if paramKey.hasSuffix("_t") {
            let prop:[String:Any] = ["value": value , "type": "array", "element_type": "text"]
            params.updateValue(prop, forKey: field)
        }
            
        return true
    }
    
    public func createMessage(eventAttributes: Dictionary<String,[Any]>,
                              parameters:Dictionary<String, Any>) -> String {
        var message: Dictionary<String, [String: [String: Any]]> = [:]
        var properties = [String: [String: Any]]()
        
        for (paramKey, pAttributes) in eventAttributes {
            let value = udf.eval(pAttributes[1] as! String, parameters, pAttributes)
            if let str = value as? String {
                if str == "" {
                    continue
                }
            }
            let pattern  = "^(.*)_(.*)"
            let regexp = try! NSRegularExpression(pattern: pattern, options: [])
            let field = regexp.stringByReplacingMatches(in: paramKey, options: [],
                                                        range: NSMakeRange(0, paramKey.utf16.count),
                                                        withTemplate: "$1")
            
            _ = fillProperties(params:&properties, paramKey: paramKey,
                                        value: value, field: field)
        }
        
        for (paramKey, value) in parameters {
            let pattern  = "^(.*)_(.*)"
            let regexp = try! NSRegularExpression(pattern: pattern, options: [])
            let field = regexp.stringByReplacingMatches(in: paramKey, options: [],
                                                        range: NSMakeRange(0, paramKey.utf16.count),
                                                        withTemplate: "$1")
            if !properties.keys.contains(field) {
                if let str = value as? String {
                    if str == "" {
                        continue
                    }
                }
                _ = fillProperties(params:&properties, paramKey: paramKey,
                                            value: value, field: field)
            }
        }
                
        message["properties"] = properties
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: message,
            options: []) {
            return String(data: theJSONData, encoding: .ascii)!
        }
        return "{}"
    }
    

    public func sendtrackingdata(labelName: String, parameters:Dictionary<String, Any>) throws {
        
        let eventAttributes: Dictionary<String,[Any]> = events.getevent(labelName)!
        var missingParams = [String]()
        for (pkey, pAttributes ) in eventAttributes {
            if pAttributes[0] as? Int == 1 && !parameters.keys.contains(pkey) {
                missingParams.append(pkey)
            }
        }
        if (missingParams.count > 0) {
            throw MyError.runtimeError("Missing Paramters : " + missingParams.joined(separator:", "))
        }
        
        let payload = createMessage(eventAttributes: eventAttributes, parameters: parameters)
        queue.enqueue(payload)
        queue.sendEvent()
    }
}
