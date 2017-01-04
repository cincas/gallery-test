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
    fileprivate var viewModel = GalleryViewModel(dataSource: DataSource.shared)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List"
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 0.0)
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        edgesForExtendedLayout = [.top]

        viewModel.prepareContent {
            self.tableView.reloadData()
        }
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
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
        return viewModel.sectionTitle(atIndex: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ListTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListTableViewCell
        cell.sectionViewModel = viewModel.sectionViewModels[indexPath.section]
        cell.collectionView.reloadData()
        cell.collectionViewCellDelegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let itemCell = cell as? ListTableViewCell else { return }

        itemCell.collectionView.collectionViewLayout.invalidateLayout()
        itemCell.collectionView.setContentOffset(.zero, animated: false)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: as for time constraint, height for collection views are hard coded here
        let section = viewModel.sectionViewModels[indexPath.section]
        switch (section.type, UIDevice.current.userInterfaceIdiom) {
        case (.normal, .phone):
            return 100
        case (.normal, _):
            return 150
        case (.large, .phone):
            return 150
        case (.large, _):
            return 250
        }
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        headerView.textLabel?.textColor = .white
        headerView.textLabel?.backgroundColor = .black
        headerView.textLabel?.textAlignment = .left
        headerView.backgroundView?.backgroundColor = .black
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
}

extension ListViewController: ItemCollectionViewCellDelegate {
    func present(_ cell: ItemCollectionViewCell) {
        let detailViewController = ItemDetailViewController(itemViewModel: cell.itemViewModel!)
        let startFrame = cell.thumbnailView.convert(cell.thumbnailView.frame, to: UIScreen.main.coordinateSpace)

        if UIDevice.current.userInterfaceIdiom == .pad {
            let fadeTransitionDelegate = NavigationTransitionDelegate(sourceView: cell.thumbnailView, destination: detailViewController, startFrame: startFrame)

            navigationController?.delegate = fadeTransitionDelegate
            navigationController?.pushViewController(detailViewController, animated: true)
        } else {
            let fadeTransitionDelegate = NavigationTransitionDelegate(sourceView: cell.thumbnailView, destination: detailViewController, startFrame: startFrame)
            detailViewController.transitioningDelegate = fadeTransitionDelegate
            detailViewController.modalPresentationStyle = .custom
            present(detailViewController, animated: true, completion: nil)
        }
    }
}

