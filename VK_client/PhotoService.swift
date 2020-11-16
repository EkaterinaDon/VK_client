//
//  PhotoService.swift
//  VK_client
//
//  Created by Ekaterina on 15.11.20.
//  Copyright © 2020 Ekaterina Donskaya. All rights reserved.
//

import UIKit

class PhotoService {
    
    private let cacheLifeTime: TimeInterval = 30 * 24 * 60 * 60
    var images: [String: UIImage] = [:]
    private static let pathName: String = {
        
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return pathName }
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        let hashName = url.split(separator: "/").last ?? "default"
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        guard
            
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cacheLifeTime,
            let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        return image
    }
    
    private func loadPhoto(url: String,completion: @escaping (UIImage) -> Void) {
        var image: UIImage = UIImage()
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: URL(string: url)!)
            
            DispatchQueue.main.async {
                image = UIImage(data: data)!
                self.images[url] = image
                completion(image)
            }
            
            self.saveImageToCache(url: url, image: image)
        }
    }
    
    
    func photo(url: String, completion: @escaping (UIImage) -> Void) {
        
        if let photo = images[url] {
            completion(photo)
        } else if let photo = getImageFromCache(url: url) {
            completion(photo)
        } else {
            loadPhoto(url: url, completion: completion)
        }
    }
    
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}
