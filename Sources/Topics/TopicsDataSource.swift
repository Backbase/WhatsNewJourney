//
//  TopicsTableViewDataSource.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit

internal class TopicsTableViewDataSource: NSObject {
    
    init(topicsViewModel: TopicsViewModel) {
        self.topicViewModel = topicsViewModel
    }
    private let topicViewModel: TopicsViewModel
}

extension TopicsTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topicViewModel.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topicCell = tableView.dequeueReusableCell(TopicCell.self)
        let topic = topicViewModel.topics[indexPath.row]
        topicCell.configure(for: topic)
        return topicCell
    }
}
