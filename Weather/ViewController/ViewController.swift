//
//  ViewController.swift
//  Weather
//
//  Created by Aye Myat Minn on 04/12/2023.
//

import UIKit
import MapKit

class ViewController: BaseViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblHumitidy: UILabel!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var topLabel1: UILabel!
    @IBOutlet weak var topLabel2: UILabel!
    @IBOutlet weak var topLabel3: UILabel!
    @IBOutlet weak var topLabel4: UILabel!
    @IBOutlet weak var topLabel5: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    
    @IBOutlet weak var bottomLabel1: UILabel!
    @IBOutlet weak var bottomLabel2: UILabel!
    @IBOutlet weak var bottomLabel3: UILabel!
    @IBOutlet weak var bottomLabel4: UILabel!
    @IBOutlet weak var bottomLabel5: UILabel!
    
    let viewModel = WeatherViewModel()
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    var weatherResult: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocation()
        getWeather()
    }

    override func bindViewModel() {
        super.bindViewModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func bindData() {
        super.bindData()
        
        
        viewModel.$weatherResult
            .receive(on: DispatchQueue.main)
            .sink { result in
                self.weatherResult = result
                self.updateUI()
            }
            .store(in: &viewModel.cancellables)
    }
    
    func getWeather() {
        viewModel.fetchOneCallWeather()
    }
    
    @IBAction func todayWeeklyValueChanged(_ sender: UISegmentedControl) {
        updateUI()
    }
    
    func getLocation() {
       
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestLocation()
        }else{
            print("Location is disable")
        }
    }
    
    func updateUI() {
        guard let weatherResult = weatherResult else {
            return
        }
        bindMainView(currentWeather: weatherResult.current, city: weatherResult.timezone)
        bindCardView()
    }
    
    func bindMainView(currentWeather: Current, city: String) {
        cityLabel.text = city
        dateLabel.text = Date().getTodaysDate()
        weatherLabel.text = currentWeather.weather[0].description.capitalized
        weatherImage.image = UIImage(named: currentWeather.weather[0].icon)
        lblTemperature.text = "\(currentWeather.temp)°C"
        lblHumitidy.text = "Humidity: \(currentWeather.humidity)%"
    }
    
    func bindCardView() {
        guard let weatherResult = weatherResult else {
            return
        }
        
        let title = getSelectedTitle()
        
        if title == "Today" {
            updateViewForToday(weatherResult.hourly)
        } else if title == "Weekly" {
            updateViewForWeekly(weatherResult.daily)
        }
    }
    
    func getSelectedTitle() -> String {
        let index = segmentedControl.selectedSegmentIndex
        let title = segmentedControl.titleForSegment(at: index) ?? ""

        return title
    }
    
    func updateViewForToday(_ hourly: [Hourly]) {
        updateHours(hourly: hourly)
    }
    
    func updateHours(hourly: [Hourly]) {
        let topLabels = [topLabel1, topLabel2, topLabel3, topLabel4, topLabel5], bottomLabels = [bottomLabel1, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5], images = [imageView1, imageView2, imageView3, imageView4, imageView5]
        for i in 0...4 {

            let hour = hourly[i + 1]
            let date = Date(timeIntervalSince1970: Double(hour.dt))
            let hourString = Date().getHourFrom(date: date)
            let weatherIconName = hour.weather[0].icon
            let weatherTemperature = hour.temp

            topLabels[i]?.text = hourString
            images[i]?.image = UIImage(named: weatherIconName)
            bottomLabels[i]?.text = "\(Int(weatherTemperature.rounded()))°F"
        }
        
    }
    
    func updateViewForWeekly(_ daily: [Daily]) {
        updateDays(daily: daily)
    }
    
    func updateDays(daily: [Daily]) {
        let topLabels = [topLabel1, topLabel2, topLabel3, topLabel4, topLabel5], bottomLabels = [bottomLabel1, bottomLabel2, bottomLabel3, bottomLabel4, bottomLabel5], images = [imageView1, imageView2, imageView3, imageView4, imageView5]
        for i in 0...4 {

            let day = daily[i + 2]
            let date = Date(timeIntervalSince1970: Double(day.dt))
            let dayString = Date().getDayOfWeekFrom(date: date)
            print("amm \(dayString)")
            let weatherIconName = day.weather[0].icon
            let weatherTemperature = day.temp.day

            topLabels[i]?.text = dayString
            images[i]?.image = UIImage(named: weatherIconName)
            bottomLabels[i]?.text = "\(Int(weatherTemperature.rounded()))°F"
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
            
            
            WeatherModel.shared.setLatitude(latitude)
            WeatherModel.shared.setLongitude(longitude)
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            print(city)
                        }
                    }
                }
            }
            
            getWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

