//
//  ViewController.swift
//  ITEA_GoogleMaps
//
//  Created by Alex Marfutin on 6/13/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MessageUI


class ViewController: UIViewController {

    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var cityNmaeLabel: UILabel!
    @IBOutlet var streetNameLabel: UILabel!
    @IBOutlet var sendUserBackGroundView: UIView!
    @IBOutlet var sendUserMainView: SendUserView!
    @IBOutlet var sendUserBackGroundLeadingConstrain: NSLayoutConstraint!
    @IBOutlet var onCloseButtonTapped: UIButton!
    @IBOutlet var userPhotoImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    
    
    var currentRecepiantMail = String()
    var currentRecepiantSms = String()
    var locationManager = CLLocationManager()
    var cityName : String?
    var usersList : [UserInfo] = UserInfoManager().getUserList()
    var cameraCoordinates = Coordinates(longtitude: 0,latitude: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentLocation()
        onCloseButtonTapped.addTarget(self, action: #selector(close), for: .touchUpInside)
        cityNmaeLabel.text = cityName
        sendUserBackGroundView.frame.size = mapView.frame.size
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 25
        
    }
    @IBAction func sendSmsButtonTapped(_ sender: UIButton) {
        sender.shake()
        sendSmsToFriend(recepiant: currentRecepiantSms)
    }
    @IBAction func sendMailButtonTapped(_ sender: UIButton) {
        sender.shake()
        sendMailToFriend(recepiant: currentRecepiantMail)
    }
}

extension ViewController: CLLocationManagerDelegate, GMSMapViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @objc func close() {
        sendUserBackGroundView.removeFromSuperview()
    }

    func sendMailToFriend(recepiant: String) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([recepiant])
        composeVC.setSubject("Hello! Greeting from Alex")
        composeVC.setMessageBody("This is hometask message for you!", isHTML: false)
        present(composeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func sendSmsToFriend(recepiant: String) {
        let composeVc = MFMessageComposeViewController()
        composeVc.messageComposeDelegate = self
        composeVc.recipients = [recepiant]
        composeVc.subject = "Hello! Greeting from Alex"
        composeVc.body = "This is hometask message for you!"
        present(composeVc, animated: true, completion: nil)
    }
    
    func setCurrentLocation() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if let userInfo = marker.userData as? [String: Any] {
            currentRecepiantMail = userInfo["email"] as! String
            currentRecepiantSms = userInfo["phone"] as! String
            userPhotoImage.image = UIImage(imageLiteralResourceName: userInfo["foto"] as! String)
            userNameLabel.text = "\(userInfo["name"] as! String) \(userInfo["surname"] as! String)"
            mapView.addSubview(sendUserBackGroundView)
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let userInfo = marker.userData as? [String: Any] {
            if let markerView = Bundle.main.loadNibNamed("MarkerInfoView", owner: self, options: nil)?[0] as? MarkerInfoView {
                
                if let name = userInfo["name"] as? String {
                    markerView.userNameLabel.text = "Name : \(name)"
                } else {
                    markerView.userNameLabel.text = "-"
                }
                
                if let surname = userInfo["surname"] as? String {
                    markerView.userSurnameLabel.text = "Surname : \(surname)"
                } else {
                    markerView.userSurnameLabel.text = "-"
                }
                
                if let adress = userInfo["adress"] as? String {
                    markerView.userAdressLabel.text = "Adress : \(adress)"
                    streetNameLabel.text = "Current location: \(adress)"
                } else {
                    markerView.userAdressLabel.text = "-"
                }
                
                if let age = userInfo["age"] as? Int {
                    markerView.userAgeLabel.text = "Age : \(String(age))"
                } else {
                    markerView.userAgeLabel.text = "-"
                }
                
                if let phone = userInfo["phone"] as? String {
                    markerView.userPhoneLabel.text = "Phone : \(phone)"
                } else {
                    markerView.userPhoneLabel.text = "-"
                }
                
                if let foto = userInfo["foto"] as? String {
                    markerView.userImage.image = UIImage(imageLiteralResourceName: foto)
                } else {
                    markerView.userImage.image = UIImage()
                }
                if let email = userInfo["email"] as? String {
                    markerView.userEmailLabel.attributedText = NSAttributedString(string: "Email : \(email)", attributes:
                        [.underlineStyle: NSUnderlineStyle.single.rawValue])
                } else {
                    markerView.userEmailLabel.text = "-"
                }
                
                markerView.userImage.clipsToBounds = true
                markerView.userImage.layer.cornerRadius = markerView.userImage.frame.height / 2
                markerView.contentView.layer.cornerRadius = 20
                markerView.contentView.layer.borderColor = UIColor.black.cgColor
                markerView.contentView.layer.borderWidth = 1.5
                
                return markerView
            } else {
                return UIView()
            }
        } else {
            return UIView()
        }
    }
    
    func setMarker(userInfoIn : UserInfo) {
        var userInfo: [String: Any] = [:]
        userInfo["name"] = userInfoIn.userName
        userInfo["surname"] = userInfoIn.userSurname
        userInfo["age"] = userInfoIn.userAge
        userInfo["adress"] = userInfoIn.userAdress
        userInfo["phone"] = userInfoIn.userPhone
        userInfo["foto"] = userInfoIn.userImage
        userInfo["email"] = userInfoIn.userEmail
        let marker = GMSMarker()
        let markerImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        markerImage.image = UIImage(named: "location")
        marker.iconView = markerImage
        marker.position.latitude = userInfoIn.coordinates.latitude
        marker.position.longitude = userInfoIn.coordinates.longtitude
        marker.userData = userInfo
        marker.map = mapView
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        getCameraCoordinates()
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(cameraCoordinates.latitude), longitude: CLLocationDegrees(cameraCoordinates.longtitude), zoom: 11.0)
        self.mapView.animate(to: camera)
        for user in usersList {
            cameraCoordinates.latitude += user.coordinates.latitude
            cameraCoordinates.longtitude += user.coordinates.longtitude
            setMarker(userInfoIn: user)
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func getCameraCoordinates() {
            for user in usersList {
                cameraCoordinates.latitude += user.coordinates.latitude
                cameraCoordinates.longtitude += user.coordinates.longtitude
            }
            cameraCoordinates.latitude = cameraCoordinates.latitude / (Double)(usersList.count)
            cameraCoordinates.longtitude = cameraCoordinates.longtitude / (Double)(usersList.count)
    }
    
}
