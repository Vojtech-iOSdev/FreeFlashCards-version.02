//
//  Query+EXT.swift
//  FreeFlashCards
//
//  Created by Vojtěch Kalivoda on 25.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

extension Query {
    
//    func getDocuments2<T>(as type: T.Type) async throws -> [T] where T : Decodable {
//        let snapshot = try await self.getDocuments()
//
//        return try snapshot.documents.map({ document in
//            try document.data(as: T.self)
//        })
//    }
    
    func getDocuments<T>(as type: T.Type) async throws -> [T] where T : Decodable {
        try await getDocumentsWithSnapshot(as: type).courses
    }
    
    func getDocumentsWithSnapshot<T>(as type: T.Type) async throws -> (courses: [T], lastDocument: DocumentSnapshot?) where T : Decodable {
        let snapshot = try await self.getDocuments()
        
        let courses = try snapshot.documents.map({ document in
            try document.data(as: T.self)
        })
        
        return (courses, snapshot.documents.last)
    }
    
    func startOptionally(afterDocument lastDocument: DocumentSnapshot?) -> Query {
        guard let lastDocument else { return self }
        return self.start(afterDocument: lastDocument)
    }
    
    func aggregateCount() async throws -> Int {
        let snapshot = try await self.count.getAggregation(source: .server)
        return Int(truncating: snapshot.count)
    }
    
    func addSnapshotListener<T>(as type: T.Type) -> (AnyPublisher<[T], Error>, ListenerRegistration) where T : Decodable {
        let publisher = PassthroughSubject<[T], Error>()
        
        let listener = self.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            let products: [T] = documents.compactMap({ try? $0.data(as: T.self) })
            publisher.send(products)
        }
        
        return (publisher.eraseToAnyPublisher(), listener)
    }
    
}
