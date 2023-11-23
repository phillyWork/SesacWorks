//
//  FileManager+Extension.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/09/05.
//

import UIKit

extension UIViewController {
    
    private func getDocumentDirectory(fileName: String) -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        return fileURL
    }
    
    func saveToDocument(fileName: String, data: UIImage) {
        guard let url = getDocumentDirectory(fileName: fileName) else { return }
        
        //Specific Data type (e.g. UIImage --> jpg)
        guard let imageData = data.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try imageData.write(to: url)
        } catch {
            print(error)
        }
        
    }
    
    func loadFromDocument(fileName: String) -> UIImage? {
        guard let url = getDocumentDirectory(fileName: fileName) else { return nil }
        
        //Specific Data type (e.g. UIImage)
        return FileManager.default.fileExists(atPath: url.path) ? UIImage(contentsOfFile: url.path) : nil
    }
    
    func removeFromDocument(fileName: String) {
        guard let url = getDocumentDirectory(fileName: fileName) else { return }
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error)
        }
    }
    
}
