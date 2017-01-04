//  Copyright © 2017 cincas. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24.0)
        ]

        let galleryViewModel = GalleryViewModel(dataSource: dummyDataSource)
        let viewController = ListViewController(viewModel: galleryViewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    private let dummyDataSource: DataSource = {
        let sectionTitles = ["Channels", "Continue", "My List", "More like The OA ", "New Release", "Tomorrow"]
        let sections = sectionTitles.flatMap { title -> Section? in
            let numberOfItems = title.characters.count
            var items = [Item]()
            for itemIndex in 0..<numberOfItems {
                let item = Item(id: "\(title)-\(itemIndex)", title: "\(title)-\(itemIndex)", imageURL: nil)
                items.append(item)
            }
            let sectionType: Section.SectionType = numberOfItems % 2 == 0 ? .normal : .large
            return Section(title: title, type: sectionType, items: items)
        }

        return DataSource(sections: sections)
    }()
}
