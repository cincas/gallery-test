//  Copyright © 2017 cincas. All rights reserved.

import Foundation

struct Item {
    let id: String
    let title: String
    var imageURL: URL?
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
    let sections: [Section]
    init(sections: [Section]) {
        self.sections = sections
    }
}
