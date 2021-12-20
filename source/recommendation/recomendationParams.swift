//
//  recomendation.swift
//  test
//
//  Created by Arvind Rapaka on 8/22/21.
//

import Foundation


import Foundation

public class RecommendationsParams {
    
    var default_attributes_event__: Dictionary<String,[Any]> = [
        "divisionId":[1, "udf_parameters:", "divisionId"],
        "uid_s":[0, "udf_parameters:" , "uid_s"],
        "orgId":[0, "udf_orgid:", ""],
        "spotDy_uid":[0, "udf_copy_parameters:" , "uid_s"],
        "pname":[0, "udf_parameters:", ""],
        "limit": [0, "udf_default:", 10],
        "domain":[0, "udf_default:", "magento"],
        "sitedomain":[0, "udf_domain:", ""],
        "com":[0, "udf_domain:", ""],
    ]
        

    var eventMap: Dictionary<String, Any> = [:]
    
    public init() {
        properties()
    }
    
    func properties() -> Void {
        let mirror = Mirror(reflecting: self)
        for (_, attr) in mirror.children.enumerated() {
            if let property_name = attr.label {
                if property_name.hasSuffix("_event__") {
                    self.eventMap.updateValue(attr.value, forKey: property_name)
                }
            }
        }
        return
    }
    
    public func getevent() -> Dictionary<String,[Any]>? {
        return default_attributes_event__
    }
    
    
    public func getevent(_ eventName: String) -> Dictionary<String,[Any]>? {
        if let event = eventMap[eventName + "__"] {
            let eventAttributes = (eventMap["default_attributes_event__"] as!
                                    Dictionary<String, Any>).merging(event as! Dictionary<String, Any>){(_, second) in second}
            return eventAttributes as! Dictionary<String,[Any]>?
        }
        return default_attributes_event__
    }
}

