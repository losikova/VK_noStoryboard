//
//  PostsJSON.swift
//  VK_noStoryboard
//
//  Created by Анастасия Лосикова on 19.02.2022.
//
import UIKit

struct PostsJSON: Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
