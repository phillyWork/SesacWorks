//
//  ViewController.swift
//  CoreLocationMapKitTheater
//
//  Created by Heedon on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class TheaterViewController: UIViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared
    
    let locationManager = CLLocationManager()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.backgroundColor = .lightGray
        map.userTrackingMode = .follow
        map.showsUserLocation = true
        return map
    }()
    
    lazy var closeBarButton: UIBarButtonItem = {
        let barbutton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftBarButtonCloseButtonTapped))
        barbutton.tintColor = .black
        return barbutton
    }()
    
    lazy var filterBarButton: UIBarButtonItem = {
        let barbutton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(rightBarButtonFilterButtonTapped))
        barbutton.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        return barbutton
    }()
    
    lazy var myCurrentLocationButton: UIBarButtonItem = {
        let barbutton = UIBarButtonItem(image: UIImage(systemName: "location"), style: .plain, target: self, action: #selector(currentMyLocationButtonTapped))
        barbutton.tintColor = .blue
        return barbutton
    }()
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .white
        
        locationManager.delegate = self
        mapView.delegate = self
        
        configUI()
        
        checkDeviceLocationAuth()
        
        setupLocationDataToMap(coordinate: dataManager.getCurrentLocation())
    }

    
    //MARK: - API for Core Location

    //check for iOS Setting
    func checkDeviceLocationAuth() {
        
        //main thread error 문제
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let status: CLAuthorizationStatus
                //get current status
                if #available(iOS 14.0, *) {
                    status = self.locationManager.authorizationStatus
                } else {
                    //less than 14.0
                    status = CLLocationManager.authorizationStatus()
                }
                //status 따른 각 case 작업 호출
                //여기부터 main thread로 다시 가져오기
                DispatchQueue.main.async {
                    self.checkLocationAuth(status: status)
                }
            } else {
                //iOS 설정에서 위치 서비스 비활성화 --> 활성화 요청
                self.showRequestLocationServiceAlert()
            }
        }
    }
    
    func checkLocationAuth(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            //최초 실행, 아무것도 선택하지 않은 상황 (Allow Once 포함)
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()             //should be same for info.plist Privacy Setting
        case .restricted:
            //e.g.) 자녀보호 모드: 권한 제한
            print("restricted auth")
        case .denied:
            showRequestLocationServiceAlert()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .authorized:
            locationManager.startUpdatingLocation()
        @unknown default:
            print("Default for later case")
        }
    }
    
    
    //MARK: - API for Map
    
    func setupLocationDataToMap(coordinate: CLLocationCoordinate2D) {
        //받은 위치를 중심으로 보여질 영역 설정하기
        let center = coordinate
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 50, longitudinalMeters: 50)
        
        //map에 해당 위치 넣기
        mapView.setRegion(region, animated: true)
        
        //기본 시작: 모든 영화관 보여주기
        setupWholeAnnotations()
    }
    
    func setupWholeAnnotations() {
        //기존 annotation 제거하고 새로 등록하기
        mapView.removeAnnotations(mapView.annotations)
        addUpAnnotationsToMap(theaterList: dataManager.getWholeList())
    }
    
    func setupTypeAnnotations(type: Theater.TheaterType) {
        //기존 annotation 제거하고 새로 등록하기
        mapView.removeAnnotations(mapView.annotations)
        let theaterList: [Theater]
        switch type {
        case .CGV:
            theaterList = dataManager.getCGVList()
        case .LotteCinema:
            theaterList = dataManager.getLotteList()
        case .MegaBox:
            theaterList = dataManager.getMegaList()
        }
        addUpAnnotationsToMap(theaterList: theaterList)
    }
    
    func addUpAnnotationsToMap(theaterList: [Theater]) {
        var annotationList = [MKPointAnnotation]()
        for theater in theaterList {
            let annotation = MKPointAnnotation()
            annotation.title = theater.locationName
            annotation.coordinate = CLLocationCoordinate2D(latitude: theater.latitude, longitude: theater.longitude)
            annotationList.append(annotation)
        }
        mapView.addAnnotations(annotationList)
    }

    
    //MARK: - Alert
    
    func showRequestLocationServiceAlert() {
      let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          //Settings로 이동
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    func showTheaterActionSheet() {
        let request = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cgv = UIAlertAction(title: "CGV", style: .default) { _ in
            self.setupTypeAnnotations(type: .CGV)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { _ in
            self.setupTypeAnnotations(type: .LotteCinema)
        }
        let mega = UIAlertAction(title: "메가박스", style: .default) { _ in
            self.setupTypeAnnotations(type: .MegaBox)
        }
        let whole = UIAlertAction(title: "전체보기", style: .default) { _ in
            self.setupWholeAnnotations()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        request.addAction(mega)
        request.addAction(lotte)
        request.addAction(cgv)
        request.addAction(whole)
        request.addAction(cancel)
        
        present(request, animated: true)
    }
    
    
    //MARK: - Handlers
    
    @objc func leftBarButtonCloseButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func rightBarButtonFilterButtonTapped() {
        showTheaterActionSheet()
    }
    
    @objc func currentMyLocationButtonTapped() {
        //move to current location
        setupLocationDataToMap(coordinate: dataManager.getCurrentLocation())
    }
}


//MARK: - Extension for Core Location Manager Delegate

extension TheaterViewController: CLLocationManagerDelegate {
    
    //location data update마다 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //가장 최근 location을 current location으로 update하기
        //위경도 data로 저장: coordinate 활용
        if let coordinate = locations.last?.coordinate {
            print("Current location: ", coordinate)
            //위치 정보 저장
            dataManager.updateCurrentUser(currentLocation: coordinate)
            
            //그 후, 지도에 해당 위경도 정보 붙이기
            setupLocationDataToMap(coordinate: dataManager.getCurrentLocation())
        }
        
        //지도에 location 설정 후, 다음 호출 전까지 update 멈추기
        locationManager.stopUpdatingLocation()
    }
    
    //location update 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showRequestLocationServiceAlert()
    }
    
    //권한 변경된 경우 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //바뀐 권한으로 다시 파악하기
        checkDeviceLocationAuth()
    }
    
    //deprecated
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkDeviceLocationAuth()
    }
    
}

//MARK: - Extension for Map View Delegate

extension TheaterViewController: MKMapViewDelegate {
    
    //지도에서 움직임, 멈추면 호출
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        //API에서 해당 위치 기반 주변 영화관 정보 얻어오기 등등...
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }
    
    //for checking when map rendering succeeds
    func mapViewDidFailLoadingMap(_ mapView: MKMapView, withError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("MapView Loading Starts!!!")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("MapView Finished Loading Map!!!")
    }
    
    
}

//MARK: - Extension for UI

extension TheaterViewController {
    
    func configUI() {
        configNavBar()
        addUpViews()
    }
    
    func configNavBar() {
        navigationItem.title = "주위 영화관 찾기"
        navigationItem.leftBarButtonItem = closeBarButton
        navigationItem.rightBarButtonItems = [myCurrentLocationButton, filterBarButton]
    }
    
    func addUpViews() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
