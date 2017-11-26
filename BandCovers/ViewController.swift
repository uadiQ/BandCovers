//
//  ViewController.swift
//  BandCovers
//
//  Created by Vadim Shoshin on 25.11.2017.
//  Copyright © 2017 Vadim Shoshin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var aaImageView: UIImageView!
    @IBOutlet private weak var aaActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var adtrImageView: UIImageView!
    @IBOutlet private weak var adtrActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var pwdImageView: UIImageView!
    @IBOutlet private weak var pwdActivityIndicator: UIActivityIndicatorView!
    
    //    private let askingAlexandria = Band(imageView: self.aaImageView, coversArray: aaCoversArray, indicator: self.aaActivityIndicator)
    //    private let aDayToRemember = Band(imageView: self.adtrImageView, coversArray: adtrCoversArray, indicator: self.adtrActivityIndicator)
    //    private let parkwayDrive = Band(imageView: self.pwdImageView, coversArray: pwdCoversArray, indicator: self.pwdActivityIndicator)
    
    private var imagesIndex = 0
    
    private let aaCoversArray = ["http://is5.mzstatic.com/image/thumb/Music2/v4/b8/a5/e1/b8a5e1b3-4e1a-37a0-167a-cff89b3c98d6/source/100000x100000-999.jpg", "https://images.genius.com/169ed2f738e0f69f95dd05825faca3df.1000x1000x1.jpg", "https://imp.imagekit.io/catalog/product/a/a/aa_fromdeath_cd_lg_1.jpg", "http://assets.blabbermouth.net.s3.amazonaws.com/media/askingalexandriatheblackcd.jpg"]
    
    private let adtrCoversArray = ["https://wallpapercave.com/wp/10fCK4l.jpg", "https://s3.amazonaws.com/rapgenius/A_Day_To_Remember_-_What_Separates_Me_From_You_-2010-.jpg", "https://fanart.tv/fanart/music/db008806-16f6-48fc-8521-3d953709689d/albumcover/common-courtesy-55bd3186960d9.jpg", "http://adtr.com/images_landing/hidden.jpg"]
    
    private let pwdCoversArray = ["http://epitaph.com/media/releases/0045778687862.png.925x925_q90.jpg", "http://epitaph.com/media/releases/0045778709564.png.925x925_q90.jpg", "http://epitaph.com/media/releases/0045778721566.png.925x925_q90.jpg", "http://epitaph.com/media/releases/0045778740260.png.925x925_q90.jpg"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshImages()
    }
    
    private func loadImageForBand(bandCoverImage: UIImageView, bandCoversArray: [String], bandImageActivityIndicator: UIActivityIndicatorView, index: Int) {
        guard index >= 0, index < bandCoversArray.count else { return }
        let stringCoverUrl = bandCoversArray[index]
        guard let coverUrl = URL(string: stringCoverUrl) else { return }
        bandImageActivityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            guard let coverData = try? Data(contentsOf: coverUrl) else {
                self?.stopAnimatingIndicator(indicator: bandImageActivityIndicator)
                return
            }
            
            let coverImage = UIImage(data: coverData)
            DispatchQueue.main.async {
                bandCoverImage.image = coverImage
                bandImageActivityIndicator.stopAnimating()
            }
        }
    }
    
    private func stopAnimatingIndicator(indicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            indicator.stopAnimating()
        }
    }
    
    private func resetImages() {
        aaImageView.image = nil
        adtrImageView.image = nil
        pwdImageView.image = nil
    }
    
    private func refreshImages() {
        loadImageForBand(bandCoverImage: aaImageView, bandCoversArray: aaCoversArray, bandImageActivityIndicator: aaActivityIndicator, index: imagesIndex)
        
        loadImageForBand(bandCoverImage: adtrImageView, bandCoversArray: adtrCoversArray, bandImageActivityIndicator: adtrActivityIndicator, index: imagesIndex)
        
        loadImageForBand(bandCoverImage: pwdImageView, bandCoversArray: pwdCoversArray, bandImageActivityIndicator: pwdActivityIndicator, index: imagesIndex)
    }
    
    @IBAction func refreshPushed(_ sender: UIButton) {
        imagesIndex = (imagesIndex + 1) % aaCoversArray.count
        resetImages()
        refreshImages()
    }
}

