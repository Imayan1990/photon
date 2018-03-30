//
//  ViewController.swift
//  ISSLocationTracking
//
//  Created by Emayavaramban Srinivasan on 3/25/18.
//  Copyright © 2018 Emayavaramban Srinivasan. All rights reserved.
//

import UIKit
import CoreLocation

/// View Controller will help user to fine the Geo Location
class ViewController: UIViewController {
    
    
    @IBOutlet weak var lookupType: UISegmentedControl!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userLatTextField: UITextField!
    @IBOutlet weak var userLonTextField: UITextField!
    var geocoder: CLGeocoder? = nil
    var userLatitude = ""
    var userLongitude = ""
    
    /**
     
     Returns the Location or coordinates based on user input.
     - parameter UISegmented instance values
     
     */
    
    @IBAction func showLookup(_ sender: Any) {
        if geocoder == nil {
            geocoder = CLGeocoder();
        }
          
        
        if lookupType.selectedSegmentIndex == 0 {
            if userTextField.text?.isEmpty ?? true {
               
                let errorAlert = UIAlertController(title: "Error", message: " Please enter value in the text box", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                  return
                }))
                 self.present(errorAlert, animated: true, completion: nil)
            }else{
            geocoder?.geocodeAddressString(userTextField.text!) {
                [weak self] placemarks, error in
                let placemark = placemarks?.first
                let latitude = placemark?.location?.coordinate.latitude
                let longitude = placemark?.location?.coordinate.longitude
                let locationString = "\(latitude!) \(longitude!)"
                self?.userLabel.text = locationString
            }
            }
            
        } else {
            
            let coords = userTextField.text?.split(separator: ",")
            let latitude = Double(coords![0])!
            let longitude = Double(coords![1])!
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            if userLatTextField.text?.isEmpty ?? true || userLonTextField.text?.isEmpty ?? true  {
                let errorAlert = UIAlertController(title: "Error", message: " Please enter correct longitude /latitude in the text box", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                    alert -> Void in
                    return
                }))
                self.present(errorAlert, animated: true, completion: nil)
                
            } else {
            geocoder?.reverseGeocodeLocation(location) {
                [weak self] placemarks, error in
                if placemarks != nil {
                    let placemark = placemarks?.first!
                    let streetNumber = placemark?.subThoroughfare
                    let street = placemark?.thoroughfare
                    let city = placemark?.locality
                    let state = placemark?.administrativeArea
                    let locationString = "\(streetNumber!) \(street!)\n\(city!), \(state!)"
                    self?.userLabel.text = locationString
                }
            }
            
        }
        }
        
    }
    
    /**
     The function wil helps to prepare the segue
     
     - parameter segue: of Type UIStoryBoardSegue
     - parameter sender : Of type optional  Any
     
     
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! ISSViewController
        vc.userlat = userLatTextField.text!
        vc.userlon = userLonTextField.text!
        print(vc)
        
    }
    
    /**
     showISS methods will pass the Data through segue
     
     - Parameter sender: Based on button click event the .this method get called
     */
    @IBAction func showISS(_ sender: Any) {
        
      
        if userLatTextField.text?.isEmpty ?? true || userLonTextField.text?.isEmpty ?? true  {
            let errorAlert = UIAlertController(title: "Error", message: " Please enter correct longitude /latitude in the text box", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                alert -> Void in
                return
            }))
            self.present(errorAlert, animated: true, completion: nil)
            
        }
          performSegue(withIdentifier: "show", sender: self)
        print("Show ISS")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


enum GeoError:Error {
    case addressError
    case coordianteError
    
    
}
