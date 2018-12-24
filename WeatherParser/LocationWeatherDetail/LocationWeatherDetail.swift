//
//  File.swift
//  WeatherParser
//
//  Created by Vamsi Chebolu on 5/22/18.
//  Copyright © 2018 Vamsi Chebolu. All rights reserved.
//

import UIKit

final class LocationWeatherDetail: UIViewController {

    private let locationListIdentifier = "locationListId"
    var earthId: Int?
    var nextFiveDayWeather = [WeatherInfo]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Weather Info"
        setUpTableView()
        loadData()        
    }
    
    // MARK: Private Methods
    private func loadData() {
        activityIndicator.startAnimating()
        let weatherRequest = LocationWeatherGETRequest(earthId: String(earthId ?? 0))
        let locationListNetworkManager = LocationWeatherDetailNetworkManager(backEndService: SessionManager(WeatherNetworking.configuration))
        locationListNetworkManager.getListOfWeatherInfoWith(request: weatherRequest) { [weak self] (weatherInfo, errorType) in
            guard let parsedWeatherInfo = weatherInfo else {
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.present(LocationListViewController.alertController(for: (errorType?.getAlertMessage() ?? "")), animated: true, completion: nil)
                }
                return
            }
            self?.nextFiveDayWeather = parsedWeatherInfo
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView?.reloadData()
            }
        }
    }
    
    private func setUpTableView() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName:"LocationListTableViewCell", bundle: nil), forCellReuseIdentifier: locationListIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        /* Just in case if the network response doesn't come back and user click back */
        if activityIndicator.isAnimating { activityIndicator.stopAnimating() }
    }
}

extension LocationWeatherDetail: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nextFiveDayWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: locationListIdentifier, for: indexPath) as? LocationListTableViewCell else { fatalError() }
        let location = nextFiveDayWeather[indexPath.row]
        cell.selectionStyle = .none
        cell.id.text = location.getHumidity()
        cell.location.text = location.getState()
        cell.title.text = ""
        return cell
    }
}
