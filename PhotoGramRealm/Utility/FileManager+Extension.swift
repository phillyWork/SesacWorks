//
//  FileManager+Extension.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    
    //Document 폴더에 이미지 저장하기
    func saveImageToDocument(fileName: String, image: UIImage) {
        //1. Document 폴더 경로 파악
        //FileManager.default : sigleton
        //documentDirectory를 url로 전달해서 path 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 저장할 세부 경로 설정 (총 url link 만들기)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 이미지 변환 (UIImage --> .jpg)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        //4. 생성한 경로에 데이터 저장하기
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    
    //Document 폴더에서 이미지 가져오기
    func loadImageFromDocument(fileName: String) -> UIImage {
        //1. Document 폴더 경로파악
        //경로 못 가져 올 경우: nil return or 대체 이미지 return하기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star.fill")! }
        
        //2. 최종 이미지 경로 파악
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 해당 경로에서 유효한 이미지 존재하면 가져오기
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
    }
    
    
    //Document 폴더에서 이미지 제거하기
    func removeImageFromDocument(fileName: String) {
        //1. Document 폴더 경로파악
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 경로 설정
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        //3. 해당 경로에서 유효한 이미지면 제거
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
        
    }
    
}
