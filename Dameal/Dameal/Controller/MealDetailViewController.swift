import UIKit

class MealDetailViewController: UIViewController {
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealIdLabel: UILabel!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var mealTagsLabel: UILabel!
    @IBOutlet weak var mealInstructionLabel: UILabel!
    
    var meal: Meal!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mealIdLabel.text = meal.idMeal
        mealNameLabel.text = meal.strMeal
        mealTypeLabel.text = meal.type
        mealTagsLabel.text = meal.tagsDisplay
        mealInstructionLabel.text = meal.instructionsDisplay
        loadImage(urlString: meal.strMealThumb)
    }
    
    func loadImage(urlString: String){
        let keyCache = urlString as NSString
        if Cache.isImageCached(key: keyCache){
            mealImageView.image = Cache.getImageCache(key: keyCache)
            return
        }
        
        mealImageView.image = UIImage(systemName: "circle.dashed")
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, data.count > 0, let image = UIImage(data: data) {
                    Cache.setImageCache(key: keyCache, image: image)
                    DispatchQueue.main.async {
                        self.mealImageView.image = image
                    }
                }else{
                    DispatchQueue.main.async {
                        self.mealImageView.image = UIImage(systemName: "xmark.octagon")
                    }
                }
            }.resume()
        }
    }
}
