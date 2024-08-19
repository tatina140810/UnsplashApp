
import UIKit
import SDWebImage
import SnapKit

class HomeViewController: UIViewController {
    
    var networkServiceMain = NetworkServiceMain()
    
    private var photos = [UnsplashPhoto]()
    private var selectedImages = [UIImage]()
    private var collectionView: UICollectionView!
    
    
    private var logoImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(resource: .logo)
        return view
    }()
    private var titleText: UILabel = {
        let view = UILabel()
        view.text = "Unsplash"
        view.font = UIFont.boldSystemFont(ofSize: 24)
        return view
    }()
    private var shareButton: UIButton =  {
        let view = UIButton()
        view.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        view.tintColor = .black
       // view.addTarget(self, action: #selector (shareButtonTapped), for: .touchUpInside)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupUI()
        fetchPhotos()
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    @objc func shareButtonTapped() {
        print("регистрация")
    
    //            let shareController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
    //
    //            shareController.completionWithItemsHandler = { _, bool, _, _ in
    //                if bool {
    //                    // self.refresh()
    //                }
    //            }
    //
    ////            shareController.popoverPresentationController?.sourceView = sender
    ////            shareController.popoverPresentationController?.permittedArrowDirections = .any
    ////            present(shareController, animated: true, completion: nil)
        }
    
    func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.reuseId)
        collectionView.backgroundColor = .white
        collectionView.allowsMultipleSelection = true
        
    }
    
    func fetchPhotos() {
        networkServiceMain.request { [weak self] data, error in
            guard let self = self, let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let unsplashPhotos = try decoder.decode([UnsplashPhoto].self, from: data)
                self.photos = unsplashPhotos
                self.collectionView.reloadData()
            } catch let error {
                print("Failed to decode JSON: \(error)")
            }
        }
    }
    
    func setupUI(){
        
        view.addSubview(logoImage)
        logoImage.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        view.addSubview(titleText)
        titleText.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(35)
            make.centerX.equalToSuperview()
            
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.reuseId, for: indexPath) as! PhotosCell
        let unsplashPhoto = photos[indexPath.row]
        cell.unsplashPhoto = unsplashPhoto
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = CGFloat(3) * 5
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        guard let image = cell.photoImageView.image else {return}
       
            selectedImages.append(image)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCell
        guard let image = cell.photoImageView.image else {return}
        if let index = selectedImages.firstIndex(of: image) {
            selectedImages.remove(at: index)
        }
    }
}
