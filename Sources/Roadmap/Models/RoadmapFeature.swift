//
//  RoadmapFeature.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation

struct RoadmapFeature: Codable, Identifiable {
    let id: String
    private let title: String?
    private var status: String? = nil
    private var description : String? = nil
    private var localizedTitle: [LocalizedItem]? = nil
    private var localizedStatus: [LocalizedItem]? = nil
    private var localizedDescription: [LocalizedItem]? = nil
    
    var featureTitle: String {
        localizedTitle.currentLocal ?? title ?? "N/A"
    }
    var featureDescription: String? {
        localizedDescription.currentLocal ?? description
    }
    var featureStatus: String? {
        localizedStatus.currentLocal ?? status
    }
    
    var hasVoted: Bool {
        get {
            guard let votes = UserDefaults.standard.array(forKey: "roadmap_votes") as? [String] else { return false }
            return votes.contains(id)
        }
        nonmutating set {
            var votes = (UserDefaults.standard.array(forKey: "roadmap_votes") as? [String]) ?? []
            if newValue {
                votes.append(id)
            } else {
                votes.removeAll(where: { $0 == id })
            }
            UserDefaults.standard.set(votes, forKey: "roadmap_votes")
        }
    }
}

struct LocalizedItem: Codable {
    let language: String
    let value: String
}

extension [LocalizedItem]? {
    var currentLocal: String? {
        self?.first(where: { $0.language == Language.code })?.value
    }
}

extension RoadmapFeature {
    static func sample() -> RoadmapFeature {
        .init(id: UUID().uuidString, title: "WatchOS Support", status: "Backlog")
    }
}
