//
//  UserCreateModel.swift
//  Ddabong2
//
//  Created by 안지희 on 1/16/25.
//


struct UserCreateModel: Codable {
    var name: String
    var id: String
    var password: String
    var joinedAt: String
    var departmentId: Int
    var jobGroup: Int
    var group: String
}
