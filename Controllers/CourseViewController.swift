//
//  CourseViewController.swift
//  ITEA_GoogleMaps
//
//  Created by Alex Marfutin on 6/27/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    
    var courseList = ["C#","PHP","Java", "DevOP"]
    var courseURL : [String?] = ["https://itea.ua/courses-itea/csharp/","https://itea.ua/courses-itea/php/","https://itea.ua/courses-itea/java-programming/","https://itea.ua/courses-itea/pm-courses/"]
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoueseTableViewCell") as! CoueseTableViewCell
        cell.courseText.text = courseList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stringURL = courseURL[indexPath.row] else {
                return
            }
        guard let url = URL(string: stringURL) else {
                 return
            }
        let request = URLRequest(url: url)
        let vc = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.urlRequest = request
        navigationController?.pushViewController(vc, animated: true)
    }
}
