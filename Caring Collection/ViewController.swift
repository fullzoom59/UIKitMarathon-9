import UIKit

class ViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInsetReference = .fromLayoutMargins
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        makeConstraints()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection"
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        var visibleRect = CGRect()
    //
    //        visibleRect.origin = collectionView.contentOffset
    //        visibleRect.size = CGSize(width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
    //
    //        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    //
    //        let visibleIndexPath: IndexPath = collectionView.indexPathForItem(at: visiblePoint) ?? IndexPath()
    //        let indexPath = IndexPath(item: visibleIndexPath.item, section: 0)
    //        collectionView.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    //        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    //    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let target = targetContentOffset.pointee
        // получить центр экрана
        let center = CGPoint(x: target.x + collectionView.bounds.width / 2, y: target.y + collectionView.bounds.height / 2)
        // получить индекс ячейки в центре экрана
        guard let indexPath = collectionView.indexPathForItem(at: center) else { return }
        // получить фрейм ячейки по индексу
        guard let attributes = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        // получить отступы коллекции
        let insets = collectionView.contentInset
        // получить размер ячейки
        let itemSize = attributes.frame.size
        // получить расстояние между ячейками
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0
        // вычислить новую позицию скролла, округлив до ближайшей ячейки и учитывая отступы, размер и расстояние
        let newX = round((target.x - insets.left) / (itemSize.width + spacing)) * (itemSize.width + spacing) + insets.left
        // установить новую позицию скролла
        targetContentOffset.pointee = CGPoint(x: newX, y: target.y)
        // выделить ячейку по индексу
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.70, height: collectionView.frame.width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 10
        return cell
    }
    
    
    func makeConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}



