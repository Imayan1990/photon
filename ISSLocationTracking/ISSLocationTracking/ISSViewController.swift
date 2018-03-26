//
//  ISSViewController.swift
//  ISSLocationTracking
//
//  Created by Emayavaramban Srinivasan on 3/25/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import UIKit

class ISSViewController: UIViewController,UICollectionViewDataSource {
    
    @IBOutlet weak var userInput: UILabel!
    var userlat:String?
    var userlon: String?
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var altitude: UILabel!
    @IBOutlet weak var passes: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    var  jsonResponse = [Response]()

    /**
 
     This method will return the number of section in the collectionView
     
     - Parameter collecview: of Type UICollectionView
     - Parameter Section : of Type Interger
 
 
   */
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(jsonResponse.count)
        return  jsonResponse.count
        
    }
    
    
    /**
        This method return collection view cell.
     
     - parameter collectionView : of Type UICollection View
     - parameter Indexpath : of type IndexPath
 
 
 
   */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "responsecell", for: indexPath) as! CustomCollectionViewCell
        
        let epoc_t_rise = TimeInterval(jsonResponse[indexPath.row].risetime)
        let unixtimestamp = Date(timeIntervalSince1970: epoc_t_rise )
        let dateFor:DateFormatter = DateFormatter()
        dateFor.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFor.locale = NSLocale.current
        dateFor.timeZone = TimeZone(abbreviation: "UTC")
        let t_risetime = dateFor.string(from: unixtimestamp)
        cell.risetime.text = String(describing: t_risetime)
        cell.duration.text = String(describing: jsonResponse[indexPath.row].duration / (60)) + "  Minutes"
        return cell
        
    }
    /**
     This method will get the data from Json and parse into an object.
     
     - parameter closure:() -> ()
 
 
 
 
    */
 
    func downloadJSON(completed: @escaping () -> () ){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userlat = userlat,let userlon = userlon {
            latitude.text = userlat
            longitude.text = userlat
            userInput.text =  " Location is \(userlat) - \(userlon)"
        }
        CollectionView.dataSource = self
        downloadJSON {
            print("successful")
            
        }

      
    }


}


