//
//  GalleryViewModel.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 2/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import Foundation

struct GalleryViewModel {
    fileprivate let dataSource = DataSource.shared
    var numberOfSections: Int {
        return dataSource.sections.count
    }

    func section(atIndex index: Int) -> Section {
        return dataSource.sections[index]
    }
}
