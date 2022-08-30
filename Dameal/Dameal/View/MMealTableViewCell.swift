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
    
    private static let semaphore = DispatchSemaphore(value: 3)
    func loadImage(urlString: String){
        let keyCache = urlString as NSString
        if Cache.isImageCached(key: keyCache){
            mealImage.image = Cache.getImageCache(key: keyCache)
            return
        }
        
        mealImage.image = UIImage(systemName: "circle.dashed")
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        DispatchQueue.global().async {
            MMealTableViewCell.semaphore.wait()
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, data.count > 0, let image = UIImage(data: data) {
                    Cache.setImageCache(key: keyCache, image: image)
                    DispatchQueue.main.async {
                        self.mealImage.image = image
                    }
                }else{
                    DispatchQueue.main.async {
                        self.mealImage.image = UIImage(systemName: "xmark.octagon")
                    }
                }
                MMealTableViewCell.semaphore.signal()
            }.resume()
        }
    }
}
