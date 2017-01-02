//
//  DataSource.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation

struct Item {
    let id: String
    let title: String
    let imageURL: URL
}

struct Section {
    enum SectionType {
        case normal
        case large
    }

    let title: String
    let type: SectionType
    let items: [Item]
}

struct DataSource {
    static let shared = DataSource(sections: generatedSections())
    let sections: [Section]
    init(sections: [Section]) {
        self.sections = sections
    }
}

fileprivate func generatedSections() -> [Section] {
    let sectionTitles = ["Channels", "Continue Watching", "Because you liked xyz", "Tomorrow", "Next week"]
    let sections = sectionTitles.flatMap { title -> Section? in
        let numberOfItems = title.characters.count
        var items = [Item]()
        for itemIndex in 0..<numberOfItems {
            let item = Item(id: "\(title)-\(itemIndex)", title: "\(title)-\(itemIndex)", imageURL: URL(string: "http://colourlovers.com.s3.amazonaws.com/images/patterns/4168/4168426.png")!)
            items.append(item)
        }
        let sectionType: Section.SectionType = numberOfItems % 2 == 0 ? .normal : .large
        return Section(title: title, type: sectionType, items: items)
    }

    return sections
}
