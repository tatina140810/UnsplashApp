//
//  SearchViewController(ViewController.swift
//  Unsplash
//
//  Created by Tatina Dzhakypbekova on 12/8/24.
//

import UIKit

class AddViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Contribute to Unsplash"
        view.font = UIFont.boldSystemFont(ofSize: 24)
        return view
        
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        view.titleLabel?.text = "Upload your photo to the largest library of open photography"
        view.tintColor = .black
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 20
        return view
    }()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    func setupUI(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(16)
            
        }
        view.addSubview(addButton)
        addButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(200)
            
        }
    }
    
  
}
