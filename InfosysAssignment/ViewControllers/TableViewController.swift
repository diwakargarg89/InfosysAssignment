//
//  TableViewController.swift
//  InfosysAssignment
//
//  Created by Diwakar Garg on 09/12/2019.
//  Copyright © 2019 Diwakar Garg. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var refreshControlView = UIRefreshControl()
    let customTableView = UITableView() // view
    var apiData = [Rows]()
    
 // MARK: - Lifecycle Of Viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(statusManager),
                                               name: .flagsChanged, object: nil)
        //Custom Method for the TableView
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if Reachability.isInternetAvailable() {
                   apiCallingUsingNativeMethods()
               } else {
                    self.alert(title: internetConnectionErrorTitle, message: internetConnectionErrorMessage)
               }
    }
    
//Custom Design of the View Progrmatically.
    func setupTableView() {
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(customTableView)
    
    //Registers a class for use in creating new table cells.
    customTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: cellId)
    customTableView.tableFooterView = UIView()
        customTableView.estimatedRowHeight = 100
        customTableView.rowHeight = UITableView.automaticDimension
        
        //set the AutoLayout
        customTableView.translatesAutoresizingMaskIntoConstraints = false
        customTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        customTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        customTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        customTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
 
        //Set the datasource and delegate to custom table view.
        customTableView.dataSource = self
        customTableView.delegate = self
        //Set the navigation Title
        navigationItem.title = navigationTitleBeforeApiLoad
    
        //Add Pull to refresh Feature
        refreshControlView.attributedTitle = NSAttributedString(string: pullToRefreshTitle)
        self.refreshControlView.addTarget(self, action: #selector(pullToRefresh), for: UIControl.Event.valueChanged)
        customTableView.addSubview(refreshControlView)
    }
    //Rerequest the Api
    @objc func pullToRefresh(sender: AnyObject) {
        //Call the api To reload the data
        if Reachability.isInternetAvailable() {
            apiCallingUsingNativeMethods()
        } else {
             self.refreshControlView.endRefreshing()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
             self.alert(title: internetConnectionErrorTitle, message: internetConnectionErrorMessage)
            }
        }
    }
 // MARK: - Network releated function
    
     //Call the Api and Load the Data to the Ui
        func apiCallingUsingNativeMethods() {
          let session = URLSession.shared
           let url = URL(string: urlString)!

           let task = session.dataTask(with: url) { data, response, error in
               if error != nil || data == nil {
                   print("Client error!")
                   return
               }

               guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                   print("Server error!")
                   return
               }
            
               do {
                let jsonDecoder = JSONDecoder()
                let utf8Data = String(decoding: data!, as: UTF8.self).data(using: .utf8)
                //Json response parsing using decode
                let responseModel: JsonParsingModel = try jsonDecoder.decode(JsonParsingModel.self, from: utf8Data!)
                print(responseModel)
                self.apiData = responseModel.rowsKey!
               DispatchQueue.main.async {
                self.navigationItem.title = responseModel.titleKey
                //Code to refresh table view
                self.refreshControlView.endRefreshing()
                self.customTableView.reloadData()
                }
               } catch {
                   print("JSON error: \(error.localizedDescription)")
               }
           }

           task.resume()
        }
    
    func updateUserInterface() {
          switch Network.reachability.status {
          case .unreachable:
             self.alert(title: internetConnectionErrorTitle, message: internetConnectionErrorMessage)
          case .wwan:
               print("WWAN connection")
          case .wifi:
               print("Wifi coonection")
          }
          print("Reachability Summary")
          print("Status:", Network.reachability.status)
          print("HostName:", Network.reachability.hostname ?? "nil")
          print("Reachable:", Network.reachability.isReachable)
          print("Wifi:", Network.reachability.isReachableViaWiFi)
      }
      
      //check the internet status
      @objc func statusManager(_ notification: Notification) {
             updateUserInterface()
         }
    
// MARK: - Table view data source

 func numberOfSections(in tableView: UITableView) -> Int {
    return 1
}

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return apiData.count
}

 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CustomTableViewCell
    
    //remove the cell selection
    cell?.selectionStyle = UITableViewCell.SelectionStyle.none
    //Set the data in to the UI
    
    if let constantTitle = apiData[indexPath.row].rowTitle {
        cell?.titleLabel.text = constantTitle
    } else {
        cell?.titleLabel.text = nilTextAssign
    }
    
    if let description = apiData[indexPath.row].description {
        cell?.descriptionTitleLabel.text = description
    } else {
        cell?.descriptionTitleLabel.text = nilTextAssign
    }
   
    if let imageHref = apiData[indexPath.row].imageHref {
        cell?.profileImageView.sd_setImage(with: URL(string: imageHref),
                                           placeholderImage: UIImage(named: "Placeholder"))
    } else {
        cell?.profileImageView.image = UIImage(named: "Placeholder")
    }
    return cell!
}
}

extension UIViewController {
    //Alert Show Details
    func alert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: okTitle, style: UIAlertAction.Style.default, handler: nil))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alertController, animated: true, completion: nil)
            // topController should now be your topmost view controller
        }
    }
}
