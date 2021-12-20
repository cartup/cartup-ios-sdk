//
//  udfs.swift
//  test
//
//  Created by Arvind Rapaka on 8/20/21.
//

import Foundation
import UIKit

public class UDFS : NSObject {
    
    var initParams: Dictionary<String, Any> = [:]
    var retvalue: Any?
    
    @objc
    public init(initParams: Dictionary<String, Any>) {
        self.initParams = initParams
    }
    
    @objc
    public func udf_getdeviceinfo(_ parameters: [Any]) -> Void {
        self.retvalue = UIDevice.current.name + "; " + UIDevice.current.systemName
    }
    
    @objc
    public func udf_getuserid(_ parameters: [Any]) -> Void {
        let userid =  initParams["orgname"] as! String + "_" + UIDevice.current.identifierForVendor!.uuidString
        self.retvalue = userid
    }
    
    @objc
    public func udf_getframework(_ parameters: [Any]) -> Void  {
        let systemVersion = UIDevice.current.systemVersion
        self.retvalue = systemVersion
    }
    
    @objc
    public func udf_sessionid(_ parameters: [Any]) -> Void  {
        guard let value = initParams["sessionId"] else {
            self.retvalue = ""
            return
        }
        self.retvalue = value
    }
    
    @objc
    public func udf_screen(_ parameters: [Any]) -> Void {
        print (parameters)
        self.retvalue = "abc"
    }
    
    @objc
    public func udf_uuid(_ parameters: [Any]) -> Void{
        self.retvalue = UUID().uuidString
    }
    
    @objc
    public func udf_domain(_ parameters: [Any]) -> Void{
        guard let domain = initParams["domain"] else {
            self.retvalue = ""
            return
        }
        self.retvalue = domain
    }
    
    @objc
    public func udf_orgid(_ parameters: [Any]) -> Void{
        guard let domain = initParams["orgid"] else {
            self.retvalue = ""
            return
        }
        self.retvalue = domain
    }
    
    
    @objc
    public func udf_orgname(_ parameters: [Any]) -> Void {
        guard let orgname = initParams["orgname"] else {
            self.retvalue = ""
            return
        }
        self.retvalue = orgname
    }
    
    @objc
    public func udf_isodate(_ parameters: [Any]) -> Void  {
        let dateFormatter = DateFormatter()
        let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        let iso8601String = dateFormatter.string(from: Date())
        self.retvalue = iso8601String
    }
    
    @objc
    public func udf_parameters(_ parameters: [Any]) -> Void  {
        let params: Dictionary <String, Any> = parameters[0] as! Dictionary <String, Any>
        let defaults: [Any] = parameters[1] as! [Any]
        guard let paramValue = params[defaults[2] as! String] else {
            self.retvalue = ""
            return
        }
        self.retvalue = paramValue
    }
    
    @objc
    public func udf_copy_parameters(_ parameters: [Any]) -> Void  {
        let params: Dictionary <String, Any> = parameters[0] as! Dictionary <String, Any>
        let defaults: [Any] = parameters[1] as! [Any]
        guard let paramValue = params[defaults[2] as! String] else {
            self.retvalue = ""
            return
        }
        self.retvalue = paramValue
    }
    
    @objc
    public func udf_default(_ parameters: [Any]) -> Void  {
        let defaults: [Any] = parameters[1] as! [Any]
        self.retvalue = defaults[2]
    }
    
    public func eval(_ funcName: String, _ parameters: Dictionary<String, Any>, _ defaults: [Any]) ->Any {
        let selector : Selector = NSSelectorFromString(funcName)
        let args : [Any] = [parameters, defaults]
        self.perform(selector, with: args)
        return self.retvalue!
    }
    
}


