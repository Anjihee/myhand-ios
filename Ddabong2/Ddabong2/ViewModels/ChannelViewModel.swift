//
//  ChannelViewModel.swift
//  Ddabong2
//
//  Created by 이윤주 on 12/28/24.
//

import Foundation
import FirebaseFirestore

class ChannelViewModel {
    private let db = Firestore.firestore()
    
    // 현재 사용자 ID (Firebase Authentication에서 가져온다고 가정)
    private let currentUserId: String
    // 생성자
    init(currentUserId: String) {
            self.currentUserId = currentUserId
    }
    
    // 채팅방 목록
    var chatRooms: [Channel] = [] {
        didSet {
            onChatRoomsUpdated?(chatRooms)
        }
    }
    
    // 데이터 업데이트 시 호출될 클로저
    var onChatRoomsUpdated: (([Channel]) -> Void)?
    

    // 특정 사용자가 포함된 채팅방 가져오기
    func fetchChatRooms() {
        db.collection("chatrooms")
                .whereField("chatMembers", arrayContains: currentUserId) // members 배열에 currentUserId가 포함된 문서만 가져옴
                .order(by: "timestamp", descending: true) // 최신 순으로 정렬
                .addSnapshotListener { [weak self] snapshot, error in
                    guard let self = self, let documents = snapshot?.documents else {
                        print("Error fetching chat rooms: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }
                    print("Fetched chat rooms: \(documents.count)")  // 얼마나 가져왔는지 확인
                    // Firebase 데이터 -> Channel 모델로 변환
                    self.chatRooms = documents.map { doc in
                        let data = doc.data()
                        return Channel(
                            id: doc.documentID,
                            chatroomName: data["chatroomName"] as? String ?? "Unknown",
                            lastMessage: data["lastMessage"] as? String ?? "",
                            timestamp: (data["timestamp"] as? Timestamp)?.dateValue() ?? Date(),
                            chatMembers: data["chatMembers"] as? [String] ?? []
                        )
                    }
                    
                }
        }
    
    // 채팅방 생성
    func createChatRoom(chatroomName: String, chatMembers: [String], completion: @escaping (String?) -> Void) {
        let chatRoomData: [String: Any] = [
            "chatroomName": chatroomName,
            "chatMembers": chatMembers,
            "lastMessage": "",
            "timestamp": FieldValue.serverTimestamp() // Firestore에서 서버 시간 추가
        ]
        
        // Firestore 문서 추가
           let collectionReference = db.collection("chatrooms")
           let documentReference = collectionReference.document() // 문서를 미리 생성하여 참조 가져오기
           documentReference.setData(chatRoomData) { error in
               if let error = error {
                   print("Error creating chat room: \(error.localizedDescription)")
                   completion(nil)
               } else {
                   print("Chat room created with ID: \(documentReference.documentID)")
                   completion(documentReference.documentID)
               }
           }
    }

    
    // 특정 채팅방의 LastMessage 업데이트
    func updateLastMessage(chatRoomId: String, lastMessage: String, timestamp:Timestamp) {
        db.collection("chatrooms").document(chatRoomId).updateData([
            "lastMessage": lastMessage,
            "timestamp" : timestamp
        ]) { error in
            if let error = error {
                print("Error updating lastMessage: \(error.localizedDescription)")
            } else {
                print("LastMessage successfully updated!")
            }
        }
    }
    
    // 채팅 나가기
    
    // 채팅방 인원 추가
    
    
}
