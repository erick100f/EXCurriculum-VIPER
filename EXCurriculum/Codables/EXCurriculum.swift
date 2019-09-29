//
//  EXCurriculum.swift
//  EXCurriculum
//
//  Created by Erick Cienfuegos on 9/29/19.
//  Copyright © 2019 Erick Cienfuegos. All rights reserved.
//

import Foundation

struct EXCurriculum:Codable{
    var name:String
    var photoURL: URL?
    var titulo:String
    var birthday:String
    var topLanguages:[String]
    var description:String
    var technical: EXTechnical?
    var professionalSummary: EXProfessionalSummary?
    var publications: EXPublications?
}

//MARK: - EXTechnical
struct EXTechnical: Codable {
    var title:String
    var items: [EXItem]
}

struct EXItem: Codable {
    var title:String
    var skills: [EXSkill]
}

struct EXSkill: Codable  {
    var title:String
    var tools: [String]
}

//MARK: - EXProfessionalSummary
struct EXProfessionalSummary: Codable {
    var title:String
    var jobs: [EXJob]
}

struct EXJob: Codable {
    var title:String
    var subtitle: String
    var description: String
    var achievement: [String]
}

//MARK: - EXPublications
struct EXPublications: Codable {
    var title:String
    var apps: [EXApp]
}

struct EXApp: Codable {
    var name:String
    var imageURL: URL?
}

