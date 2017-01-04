## Goal

This is an example app for displaying 2D data set by using UITableView and UICollectionView, requirements are listed in <u>*Switch Media - Native iOS Carousels.pdf.*</u>

## Specs

- **Support device**: iPhone and iPad.
- **Support OS version**: iOS 9 & 10 (**tested in 9.3, 10.1, and 10.2**).
- **Support orientation**: Landscape & Portrait.

## Unsolved issues	

- [ ] Dynamic collection view cell size, currently use predefined height for different styles.
- [ ] ImageView reuse problem: The `ImageDownloader` uses a hash table to manage `UIImageView` and `ImageDownloadTask` in order to avoid a race condition issue.
- [ ] `PresentationAnimator` takes a blank `snapshotView` in iPhone.

## Release notes

1. <u>*\[2017-01-02\]*</u>: Draft with basic layout.
2. <u>*\[2017-01-03\]*</u>: Add random image logic and styling.
3. <u>*\[2017-01-04\]*</u>: Imporve `ImageDownloader` .