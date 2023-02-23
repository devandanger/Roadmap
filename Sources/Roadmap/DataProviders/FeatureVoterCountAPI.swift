//
//  FeatureVoterCountAPI.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation

struct FeatureVoterCountAPI: FeatureVoter {
    let feature: RoadmapFeature
    let namespace: String
    
    /// Fetches the current count for the given feature.
    /// - Returns: The current `count`, else `0` if unsuccessful.
    func fetch() async -> Int {
        do {
            let urlString = "https://api.countapi.xyz/get/\(namespace)/feature\(feature.id)"
            let count: RoadmapFeatureVotingCount = try await JSONDataFetcher.loadJSON(fromURLString: urlString)
            return count.value ?? 0
        } catch {
            print("Fetching voting count failed with error: \(error.localizedDescription)")
            return 0
        }
    }

    /// Votes for the given feature.
    /// - Returns: The new `count` if successful.
    func vote() async -> Int? {
        do {
            let urlString = "https://api.countapi.xyz/hit/\(namespace)/feature\(feature.id)"
            let count: RoadmapFeatureVotingCount = try await JSONDataFetcher.loadJSON(fromURLString: urlString)
            feature.hasVoted = true
            print("Successfully voted, count is now: \(count)")
            return count.value
        } catch {
            print("Voting failed: \(error.localizedDescription)")
            return nil
        }
    }
}
