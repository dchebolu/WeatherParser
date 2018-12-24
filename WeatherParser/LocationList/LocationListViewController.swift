//
//  ViewController.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import UIKit
import CoreLocation

final class LocationListViewController: UIViewController {

    private let locationManager = CLLocationManager()
    private let locationListIdentifier = "locationListId"
    private var weatherLocations = [Location]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Locations Near me"
        self.navigationItem.hidesSearchBarWhenScrolling = false
        setUpLocationManager()
        setUpTableView()
        setUpSearchBar()
        getGPSAuthorization()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchController.dismiss(animated: false, completion: nil)
        /* Just in case if the network response doesn't come back and user click detail info */
        if activityIndicator.isAnimating { activityIndicator.stopAnimating() }
    }
    
    @IBAction func refreshData(sender: UIBarButtonItem) {
        self.weatherLocations.removeAll()
        self.tableView.reloadData()
        getGPSAuthorization()
    }
    
    // MARK: Private Methods
    private func setUpSearchBar() {
        // SetUp the search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Location"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName:"LocationListTableViewCell", bundle: nil), forCellReuseIdentifier: locationListIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setUpLocationManager() {
        // For Location Manager.
        // We will only request authorization while using the app.
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        /* Be a good samaritan since we do not need very specific location data. */
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    private func loadDatawith(params: Parameters) {
        activityIndicator.startAnimating()
        let locationRequest = LocationListGETRequest(urlParameter: params, body: nil, rawBody: nil)
        let locationListNetworkManager = LocationListNetworkManager(backEndService: SessionManager(WeatherNetworking.configuration))
        locationListNetworkManager.getListOfLocationsWith(request: locationRequest) { [weak self] (locations, errorType) in
            guard let parsedlocations = locations else {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.present(LocationListViewController.alertController(for: (errorType?.getAlertMessage() ?? "")), animated: true, completion: nil)
                }
                return
            }
            self?.weatherLocations = parsedlocations
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView?.reloadData()
            }
        }
    }
    
    private func getGPSAuthorization() {
        /* If user has not accepted yet, they are being prompted. */
        if CLLocationManager.authorizationStatus() == .notDetermined {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse  {
            locationManager.startUpdatingLocation()
        } else {
            let alert = UIAlertController(title: "Error", message: "Could not get location. If it is not turned on, please turn it on in your settings.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true) {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LocationWeatherDetail, let selectedRow = tableView.indexPathForSelectedRow?.row {
            destinationVC.earthId = weatherLocations[selectedRow].id
        }
    }
}

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: locationListIdentifier, for: indexPath) as? LocationListTableViewCell else { fatalError() }
        let location = weatherLocations[indexPath.row]
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.id.text = location.getLocationId()
        cell.location.text = location.getLocationType()
        cell.title.text = location.getLocationTitle()
        return cell
    }
}

// MARK: CLLocationManagerDelegate
extension LocationListViewController: CLLocationManagerDelegate {
    /* The location currently triggers multiple times, so I would further do logic to get this to happen once. To the user, this works fine for now. */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        /* Get first location for API. */
        guard let location = locations.first else {
            return
        }
        
        manager.stopUpdatingLocation()
        let gpsInfo = [String(location.coordinate.latitude), String(location.coordinate.longitude)]
        loadDatawith(params: UrlParamString.gps.getParameterStringFor(params: gpsInfo))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            self.activityIndicator.stopAnimating()
        }
        if status == .authorizedWhenInUse {
            self.activityIndicator.startAnimating()
            manager.startUpdatingLocation()
        }
    }
}

// MARK: SearchBar delegate
extension LocationListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        /* Make the request call when the letters are atleast 3 letters for optimization purpose. */
        if searchController.searchBar.text?.count ?? 0 >= 3 {
            self.weatherLocations.removeAll()
            self.tableView.reloadData()
            loadDatawith(params: UrlParamString.search.getParameterStringFor(params: [searchController.searchBar.text ?? ""]))
        }
    }
}
