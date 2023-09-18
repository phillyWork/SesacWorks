//
//  PhotoViewModel.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

//import Foundation

//for UIImage in cell
import UIKit

class PhotoViewModel {
    
    //Observable로 감싸기 (Generic 처리 --> Photo 구조체도 okay)
    //data 변경되면 작업되도록 실시간 대응되도록 함
    //value로 값 꺼내오기
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
        
    //연산 프로퍼티로 작업 더 가져와보기
    //logic 숨기기 및 optional 처리 여기서 다 하고 나가기
    var numberOfRowsInSection: Int {
        return list.value.results?.count ?? 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
    
    
    //네트워크 통신: 비즈니스 로직 일부
    //singleton 가져오기
    let apiService = APIService.shared
    
    func fetchPhoto(text: String) {
        apiService.searchPhoto(query: text) { photo in
            //응답은 main에서 처리하기
            DispatchQueue.main.async {
                guard let photo = photo else { return }
                
                //Cannot assign value of type 'Photo' to type 'Observable<Photo>'
    //            self.list = photo
                
                //실제 타입 update: value 활용
                self.list.value = photo
            }
        }
    }
 
    
    func getPhotoWithURL(indexPath: IndexPath, completionHandler: @escaping (UIImage) -> ()) {
        if let photo = list.value.results?[indexPath.row], let url = URL(string: photo.urls.thumb) {
            DispatchQueue.global().async {
                do {
                    let imageData = try Data(contentsOf: url)
                    if let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            completionHandler(image)
                        }
                    }
                } catch {
                    print("Image From Network Error")
                }
            }
        }
    }
    
    
}
