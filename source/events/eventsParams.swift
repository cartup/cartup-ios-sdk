//
//  events.swift
//  test
//
//  Created by Arvind Rapaka on 8/20/21.
//

import Foundation

public class Events {
    
    var default_attributes_event__: Dictionary<String,[Any]> = [
        "uid_s":[0, "udf_getuserid:", ""],
        "domain_s":[0, "udf_domain:", ""],
        "referralDomainName_s":[0, "udf_domain:", ""],
        
        "_ga_s":[0, "udf_parameters:", "_ga"],
        "_fbp_s":[0, "udf_parameters:", "_fbp"],
        
        "browserInfo_s":[0, "udf_default:", "ios_mobile_native"],
        "is_mobile_b":[0, "udf_default:", true],
        
        "date_dt": [0, "udf_isodate:", ""],
        "org_s":[0, "udf_orgname:", "org_s", ""],
        "currentPageUrl_s":[0, "udf_screen:", ""],
        "spotdySessionId_s":[0, "udf_sessionid:", ""],
        "deviceInfo_s":[0, "udf_getdeviceinfo:", ""],
        "framework_s":[0, "udf_getframework:", ""],
        "spotdy_eventid_s":[0, "udf_uuid:", ""],
        "orgId_s":[0, "udf_orgid:", ""],
    ]
    
    
    var productview_event__: Dictionary<String,[Any]> = [
        "productname_s":[1, "udf_parameters:", "productname_s"],
        "sku_s":[1, "udf_parameters:", "sku_s"],
        "price_d":[1, "udf_parameters:", "price_d"],
        "discountprice_d":[0, "udf_parameters:", "discountprice_d"],
        
        "eventType_s":[0, "udf_default:", "productview"],
        "labelName_s":[0, "udf_default:", "productview"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_productview"],
        "eventAction_s":[0, "udf_default:", "load"]
    ]
    
    
    var addtocart_event__: Dictionary<String,[Any]> = [
        
        "productname_s":[1, "udf_parameters:", "productname_s"],
        "sku_s":[1, "udf_parameters:", "sku_s"],
        "price_d":[1, "udf_parameters:", "price_d"],
        
        "eventType_s":[0, "udf_default:", "addtocart"],
        "eventAction_s":[0, "udf_default:", "click"],
        "labelName_s":[0, "udf_default:", "addtocart"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_addtocart"]
        
    ]
    
    var viewcart_event__: Dictionary<String,[Any]> = [
        
        "productname_ss":[1, "udf_parameters:", "productname_ss"],
        "sku_ss":[1, "udf_parameters:", "sku_ss"],
        "price_ds":[1, "udf_parameters:", "price_ds"],
        "quantity_ls":[1, "udf_parameters:", "quantity_ls"],
        "totalamount_d":[1, "udf_parameters:", "totalamount_d"],
        
        "eventType_s":[0, "udf_default:", "viewcart"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "viewcart"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_cartview"]

    ]
    
    var transaction_event__: Dictionary<String,[Any]> = [
        "productname_ss":[1, "udf_parameters:", "productname_ss"],
        "sku_ss":[1, "udf_parameters:", "sku_ss"],
        "price_ds":[1, "udf_parameters:", "price_ds"],
        "quantity_ls":[1, "udf_parameters:", "quantity_ls"],
        "totalamount_d":[1, "udf_parameters:", "totalamount_d"],
        
        "eventType_s":[0, "udf_default:", "Transaction"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "postcheckout"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_transactions"]

    ]
    
    var addtowishlist_event__: Dictionary<String,[Any]> = [
        "productname_s":[1, "udf_parameters:", "productname_s"],
        "sku_s":[1, "udf_parameters:", "sku_s"],
        "price_d":[1, "udf_parameters:", "price_d"],
        
        "eventType_s":[0, "udf_default:", "addtowishlist"],
        "eventAction_s":[0, "udf_default:", "click"],
        "labelName_s":[0, "udf_default:", "wishlist"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_wishlist"],
        "__count_i": [0, "udf_default:", 1]

    ]
    
    var widgetLoad_event__: Dictionary<String,[Any]> = [
        "widgetId_s":[1, "udf_parameters:", "widgetId_s"],

        
        "eventType_s":[0, "udf_default:", "widgetLoad"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "widgetLoad"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_widget_load"],
        "__count_i": [0, "udf_default:", 1]

    ]
    
    var widgetClick_event__: Dictionary<String,[Any]> = [
        "widgetId_s":[1, "udf_parameters:", "widgetId_s"],
        "product_name_s":[1, "udf_parameters:", "product_name_s"],
        "sku_s":[1, "udf_parameters:", "sku_s"],
        "price_s":[1, "udf_parameters:", "price_s"],
        
        "eventType_s":[0, "udf_default:", "widgetLoad"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "widgetLoad"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_widget_click"]

    ]
    
    var widgetView_event__: Dictionary<String,[Any]> = [
        "widgetId_s":[1, "udf_parameters:", "widgetId_s"],

        
        "eventType_s":[0, "udf_default:", "__widget_view__"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "widgetView"],
        "spotdy_eventname_s":[0, "udf_default:", "__widget_view__"]

    ]
    
    var signup_event__: Dictionary<String,[Any]> = [
        "uid_s":[1, "udf_parameters:", "uid_s"],
        "emailid_s":[0, "udf_parameters:", "emailid_s"],
        "gender_s":[0, "udf_parameters:", "gender_s"],
        "city_s": [0, "udf_parameters:", "city_s"],
        

        "eventType_s":[0, "udf_default:", "signup"],
        "eventAction_s":[0, "udf_default:", "click"],
        "labelName_s":[0, "udf_default:", "signup"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_signup"]

    ]
    
    var signout_event__: Dictionary<String,[Any]> = [
        "uid_s":[1, "udf_parameters:", "uid_s"],
        
        "eventType_s":[0, "udf_default:", "signout"],
        "eventAction_s":[0, "udf_default:", "click"],
        "labelName_s":[0, "udf_default:", "signout"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_signout"]

    ]
    
    var search_event__: Dictionary<String,[Any]> = [
        "keyword_s":[1, "udf_parameters:", "keyword_s"],
        
        "eventType_s":[0, "udf_default:", "Search View"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "searchview"],
        "spotdy_eventname_s":[0, "udf_default:", "__ecomtics_search"]

    ]
    
    var review_event__: Dictionary<String,[Any]> = [
        "reviewtext_txt":[1, "udf_parameters:", "review_txt"],
        "productname_s":[1, "udf_parameters:", "productname_s"],
        "sku_s":[1, "udf_parameters:", "sku_s"],
        "price_d":[1, "udf_parameters:", "price_d"],
        "userid_s":[1, "udf_parameters:", "userid_s"],
        
        "eventType_s":[0, "udf_default:", "ratingandreviews"],
        "eventAction_s":[0, "udf_default:", "click"],
        "labelName_s":[0, "udf_default:", "review"],
        "spotdy_eventname_s":[0, "udf_default:", "__spotdy_reviewratings"]

    ]
    
    var click_event__: Dictionary<String,[Any]> = [
        "eventType_s":[0, "udf_default:", "custom_click"],
        "eventAction_s":[0, "udf_default:", "click"],
        "labelName_s":[0, "udf_default:", "custom_click"]
    ]
    
    var load_event__: Dictionary<String,[Any]> = [
        "eventType_s":[0, "udf_default:", "custom_load"],
        "eventAction_s":[0, "udf_default:", "load"],
        "labelName_s":[0, "udf_default:", "custom_load"]

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
    
    public func getevent(_ eventName: String) -> Dictionary<String,[Any]>? {
        if let event = eventMap[eventName + "__"] {
            let eventAttributes = (eventMap["default_attributes_event__"] as!
                                    Dictionary<String, Any>).merging(event as! Dictionary<String, Any>){(_, second) in second}
            return eventAttributes as! Dictionary<String,[Any]>?
        }
        return nil
    }
}
