import UIKit

class MealHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private static let TABLE_CELL_IDENTIFIER = "MealCell"
    
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigation()
        setupTableView()
        loadMeals()
    }
    
    func setupNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor(red: 15, green: 176, blue: 128, alpha: 1)
        navigationItem.title = "Meals"
        navigationItem.titleView?.tintColor = UIColor(red: 15, green: 176, blue: 128, alpha: 1)
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.register(
            UINib(nibName: "MMealTableViewCell", bundle: nil),
            forCellReuseIdentifier: MealHomeViewController.TABLE_CELL_IDENTIFIER
        )
    }
    
    func loadMeals(){
        DispatchQueue.global().async {
            Meal.getMeals(onerror: {
                print("Meal cannot be loaded")
            }){ [weak self] meals in
                self?.meals.append(contentsOf: meals)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: MealHomeViewController.TABLE_CELL_IDENTIFIER,
            for: indexPath
        ) as? MMealTableViewCell{
            let meal = meals[indexPath.row]
            cell.applyUI(meal: meal)
            return cell
        } else{
            return UITableViewCell()
        }
    }
}

