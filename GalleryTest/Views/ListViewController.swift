//
//  ListViewController.swift
//  GalleryTest
//
//  Created by Yang, Tyler on 1/1/17.
//  Copyright © 2017 cincas. All rights reserved.
//

import UIKit

private let cellIdentifier = "cell"
class ListViewController: UITableViewController {
    fileprivate var viewModel = GalleryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        tableView.backgroundColor = .white
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        // TODO: as for time constraint, height for collection views are hard coded here
        tableView.rowHeight = 250.0
    }
}

extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.section(atIndex: section).title
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ListTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        cell.section = viewModel.section(atIndex: indexPath.section)
        cell.collectionViewCellDelegate = self
        return cell
    }
}

extension ListViewController: ItemCollectionViewCellDelegate {
    func present(_ cell: ItemCollectionViewCell, fromRect rect: CGRect, withItem item: Item) {
        let detailViewController = ItemDetailViewController(item: item, image: cell.thumbnailView.image)
        let startFrame = cell.thumbnailView.convert(cell.thumbnailView.frame, to: view)

        let fadeTransitionDelegate = NavigationTransitionDelegate(sourceView: cell.thumbnailView, destination: detailViewController, startFrame: startFrame)

        navigationController?.delegate = fadeTransitionDelegate
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

