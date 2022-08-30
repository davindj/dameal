import UIKit

class MMealTableViewCell: UITableViewCell {
    @IBOutlet weak var mealIdLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyUI(meal: Meal){
        mealNameLabel.text = meal.strMeal
        mealTypeLabel.text = meal.type
        mealIdLabel.text = meal.idMeal
        loadImage(urlString: meal.strMealThumb)
    }
    
    func loadImage(urlString: String){
        let keyCache = urlString as NSString
        if Cache.isImageCached(key: keyCache){
            mealImage.image = Cache.getImageCache(key: keyCache)
            return
        }
        
        mealImage.image = UIImage(systemName: "circle.dashed")
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, data.count > 0 {
                if let image = UIImage(data: data) {
                    Cache.setImageCache(key: keyCache, image: image)
                }else{
                    self.mealImage.image = UIImage(systemName: "xmark.octagon")
                }
            } else {
                self.mealImage.image = UIImage(systemName: "xmark.octagon")
            }
        }.resume()
    }
}
