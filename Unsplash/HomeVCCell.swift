//
//  HomeVCCell.swift
//  Unsplash
//
//  Created by Tatina Dzhakypbekova on 13/8/24.
//

import UIKit

class HorizontalCVCell: UICollectionViewCell {
    func config(image: UIImage?){
        imageView.image = image
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initiolize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
}
private extension HorizontalCVCell {
    func initiolize() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints{ make in
            make.edges.equalToSuperview().inset(5)
            make.size.equalTo(140)}
        
    }
}
