import Foundation
import UIKit

import Foundation

struct Meal: Codable {
    let idMeal, strMeal, strCategory, strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    
    var type: String{
        "\(strCategory); \(strArea)"
    }
    var instructions: [String] {
        strInstructions.split(separator: "\n").map{ String($0) }
    }
    
    static func getMeals(onerror: @escaping ()->Void, oncompletion: @escaping ([Meal])->Void){
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?f=b")!
        let task = URLSession.shared.dataTask(with: url){ [oncompletion] (data, response, error) in
            if let _ = error {
                onerror()
            }
            if let data = data, let mealWrapper = try? JSONDecoder().decode(MealWrapper.self, from: data) {
                oncompletion(mealWrapper.meals)
            }
        }
        task.resume()
    }
}

struct MealWrapper: Codable{
    let meals: [Meal]
}
