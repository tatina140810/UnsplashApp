//
//  SearchViewController(ViewController.swift
//  Unsplash
//
//  Created by Tatina Dzhakypbekova on 12/8/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    var networkDataFetch = NetworkDataFetch()
    private var timer: Timer?
    private var photos = [UnsplashPhoto]()
    private let itemsPerRow: CGFloat = 2
    private let sectionInsert = UIEdgeInsets (top: 5, left: 5, bottom: 5, right: 5)
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.isUserInteractionEnabled = true
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.backgroundColor = .white
        searchBar.keyboardType = .default
        searchBar.becomeFirstResponder()
        searchBar.placeholder = "Search here..."
        return searchBar
    }()
    
    
    private var firstLabel: UILabel =  {
        let view = UILabel()
        view.text = "Browse by Category"
        view.font = UIFont.boldSystemFont(ofSize: 24)
        return view
        
    }()
    
    private var vertCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
        setupUI()
    }
    
    func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        vertCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vertCollectionView.delegate = self
        vertCollectionView.dataSource = self
        vertCollectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)
        vertCollectionView.backgroundColor = .white
    }
    
    func setupUI() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        view.addSubview(firstLabel)
        firstLabel.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        view.addSubview(vertCollectionView)
        vertCollectionView.snp.makeConstraints{make in
            make.top.equalTo(firstLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vertCollectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId, for: indexPath) as! PhotosCell
        
        let unsplashPhoto = photos[indexPath.row]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
}

// Mark: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let photo = photos[indexPath.item]
        let paddingSpace = CGFloat(3) * 5
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsert
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsert.left
    }
}


// Mark: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetch.fetchImages(searchTerm: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.photos = fetchedPhotos.results
                self?.vertCollectionView.reloadData()
                
            }
        })
    }
    
}


