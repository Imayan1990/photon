//
//  JSONHelper.swift
//  ISSLocationTracking
//
//  Created by Emayavaramban Srinivasan on 3/29/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import Foundation

extension ISSViewController {
    
      public  func downloadJSON(completed: @escaping () -> () ){
            let url = URL(string: "http://api.open-notify.org/iss-pass.json?lat=\(userlat!)&lon=\(userlon!)")
            URLSession.shared.dataTask(with: url!) { (data,response, error) in
                if error == nil{
                    do{
                        let json = try  JSONDecoder().decode(ISSJsonData.self, from: data!)
                        self.jsonResponse = json.response
                        DispatchQueue.main.async {
    
                            self.altitude.text  = String(json.request.altitude)
                            self.longitude.text = String(json.request.longitude)
                            self.latitude.text = String(json.request.latitude)
                            self.passes.text = String(json.request.passes)
                            print(json)
                            completed()
                            self.CollectionView.reloadData()
    
                        }
                    } catch {
    
                        print("Json Error")
                    }
                }
                }.resume()
    
        }
    
}
