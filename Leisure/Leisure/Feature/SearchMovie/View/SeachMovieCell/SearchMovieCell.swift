//
//  SearchMovieCell.swift
//  Leisure
//
//  Created by Mamta Sharma on 8/18/21.
//

import UIKit
import SDWebImage

protocol SearchMovieCellDelegate: AnyObject {
    func btnActionCallApi(_ action: ActionType,
                          _ indexPath: IndexPath?)
    func playDummyTrailer()
}
extension SearchMovieCellDelegate {
    func playDummyTrailer() {}
}
class SearchMovieCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var watchLaterBtn: UIButton!
    @IBOutlet weak var watchTrailerBtn: UIButton!
    weak var delegate: SearchMovieCellDelegate?
    var indexPath: IndexPath?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setUpCell(_ model: LEMovie, indexPath: IndexPath?) {
        self.indexPath = indexPath
        if let imagePath = model.posterPath, let imageUrl = URL(string: Services.imageBaseUrl+imagePath) {
            coverImageView?.sd_setImage(with: imageUrl,
                                        placeholderImage: UIImage(named: "placeholder.png"),
                                        options: .refreshCached) { (_, _, _, _) in
            }
        }

        if model.isfav {
            likeBtn?.setImage(UIImage.init(named: "liked"), for: .normal)
        } else {
            likeBtn?.setImage(UIImage.init(named: "like"), for: .normal)
        }

        if model.isWatch {
            watchLaterBtn?.setImage(UIImage.init(named: "watchlater"), for: .normal)
        } else {
            watchLaterBtn?.setImage(UIImage.init(named: "watchlaterUnselect"), for: .normal)
        }

        titleLbl?.text = model.title ?? ""
        descriptionLbl?.text = model.overview ?? ""
    }

    @IBAction func likeBtnAction(_ sender: Any) {
        delegate?.btnActionCallApi(.fav, self.indexPath)
    }
    @IBAction func watchTrailerBtnAction(_ sender: Any) {
        delegate?.playDummyTrailer()
    }
    @IBAction func watchLaterBtnAction(_ sender: Any) {
        delegate?.btnActionCallApi(.watchList, self.indexPath)
    }
}
