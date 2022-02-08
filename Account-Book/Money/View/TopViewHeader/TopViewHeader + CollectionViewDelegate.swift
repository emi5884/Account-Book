import UIKit

// MARK: - UICollectionViewDataSource

extension TopViewHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryViewIdentifier, for: indexPath)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TopViewHeader: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TopViewHeader: UICollectionViewDelegateFlowLayout {
    
}
