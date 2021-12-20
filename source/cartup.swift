//
//  cartup.swift
//  test
//
//  Created by Arvind Rapaka on 8/22/21.
//

import Foundation

public class Cartup {
    
    var orgname: String
    var orgid: String
    var secretkey: String
    var domain: String
    var eventHandler: EventHandler
    var recommendationHandler: RecommendationHandler
   
    
    public init(orgname: String, orgid: String, secretkey: String, domain: String) {
        self.orgid = orgid
        self.secretkey = secretkey
        self.orgname = orgname
        self.domain = domain
        self.eventHandler = EventHandler(orgname, orgid, secretkey, domain)
        self.recommendationHandler = RecommendationHandler(orgname, orgid, secretkey, domain)
       
    }
    
    public func inititalize(orgname: String, orgid: String, secretkey: String, domain: String) {
        self.orgid = orgid
        self.secretkey = secretkey
        self.orgname = orgname
        self.domain = domain
        self.eventHandler = EventHandler(orgname, orgid, secretkey, domain)
        self.recommendationHandler = RecommendationHandler(orgname, orgid, secretkey, domain)
    }
    
    public func getRecommendationHandler() -> RecommendationHandler {
        return recommendationHandler
    }
    
    public func getEventHandler() -> EventHandler {
        return eventHandler
    }
    
}
