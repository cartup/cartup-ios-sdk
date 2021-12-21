//
//  ContentView.swift
//  SimpleApplication
//
//  Created by Arvind Rapaka on 9/4/21.
//

import SwiftUI
import cartupEventRecoSDK

func completion(_ result: Result<(Data, URLResponse), Error>) -> Void{
    do {
        let (data, response) = try result.get()
        guard let lresponse = response as? HTTPURLResponse, (200...299).contains(lresponse.statusCode) else {
            print("Server error!")
            return
        }
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        print(json)
    } catch let error {
        debugPrint(error)
    }
}

struct ContentView: View {
   var body: some View {
        Text("Hello, world!")
            .padding()
    }
    init() {
        //recoEvent()
        event()
    }
    func event() -> Void {
        let cartup = Cartup(orgname:"Greenwallet", orgid:"Greenwallet-ABC", secretkey:"SECRET-KEY-1234", domain:"greenwallet.com")
        let cartupEHandler = cartup.getEventHandler()
        var pd = [String: Any]()
        pd.updateValue(10.22, forKey: "price_d")
        pd.updateValue("Paw Patrol", forKey: "productname_s")
        pd.updateValue("SKU-123", forKey: "sku_s")
        pd.updateValue("user-arvind", forKey: "uid_s")
        pd.updateValue("user-arvind-test", forKey: "test_s")
        do {
            try cartupEHandler.sendtrackingdata(labelName: "productview_event", parameters: pd)
        } catch let error as NSException {
            print("Encountered error: \(error)")
        } catch  {
            print("Encountered error: \(error)")
        }
        return
    }
    
    func recoEvent() -> Void {
        let cartup = Cartup(orgname:"intertoys_live", orgid:"9f630604-daa1-455d-aceb-a4150fa9127c", secretkey:"SECRET-KEY-1234", domain:"intertoy.com")
        let cartupRHandler = cartup.getRecommendationHandler()
        var pd = [String: Any]()
        pd.updateValue("live_recentviews", forKey: "divisionId")
        pd.updateValue("ef2f45a5-3f49-4dfb-a893-580aa64c15de", forKey: "uid_s")
        do {
            try cartupRHandler.getRecommendations(parameters:pd, completion)
    
        } catch {
            print("Encountered error: \(error)")
        }
        return
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
