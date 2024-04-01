//
//  FirebaseManager.swift
//  Code Buddy
//
//  Created by furkan vural on 25.03.2024.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


final class FirebaseManager {
    
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private let id = Auth.auth().currentUser?.uid
    private let encoder = JSONEncoder()
    
    private init() {}
    
    func createUser() {
        
    }
    
    
    func getAllUser() {
        
    }
    
    func uploadImage(imageData: Data, user: User, completion: @escaping (Result<Bool, Error>) -> Void) {

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("Images")
        let imageReference = mediaFolder.child("image.jpg")
        let uploadTask = imageReference.putData(imageData, metadata: nil) { metaData, error in
            if error != nil {
                completion(.failure(error!))
            } else {
                imageReference.downloadURL { [self] url, error in
                    if error == nil {
                        let imageUrl = url?.absoluteString
                        UserDefaults.standard.set(imageUrl!, forKey: "userImageURL")
                        let newUser = User(name: user.name, title: user.title, status: user.status, location: user.location, id: user.id, imageURL: imageUrl!)
                        
                        self.addDataToDB(collection: "Users", secondCollection: nil, document: id!, data: newUser) { result in
                            switch result {
                            case .success(_):
                                completion(.success(true))
                                return
                            case .failure(let failure):
                                completion(.failure(failure))
                                return
                            }
                        }
                    }
                }
            }
        }
        
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print("Yükleme yüzdesi: \(percentComplete)%")
        }
        
        uploadTask.observe(.success) { snapshot in
            print("Yükleme başarıyla tamamlandı. ✅")
        }
    }
    
    func addDataToDB<T: Codable>(collection: String, secondCollection: String? = nil, document: String, data: T, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard secondCollection == nil else {
            do {
                let jsonData = try encoder.encode(data)
                let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                let collectionRef = db.collection(collection).document(id!).collection(secondCollection!).document()
                
                collectionRef.setData(json) { error in
                    guard error == nil else {
                        completion(.failure(error!))
                        return
                    }
                    completion(.success(true))
                    return
                }
                
            } catch {
                print("Veri dönüştürülürken hata oluştu: ❌ \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            return
        }
        
        do {
            let jsonData = try encoder.encode(data)
            let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            let collectionRef = db.collection(collection).document(document)
            
            collectionRef.setData(json) { error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(true))
            }
            
        } catch {
            print("Veri dönüştürülürken hata oluştu: ❌ \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
