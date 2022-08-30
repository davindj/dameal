import UIKit

class AboutDeveloperViewController: UIViewController {
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var linkedinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func githubButtonOnClick(_ sender: Any) {
        if let url = URL(string: "https://github.com/davindj") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func instagramButtonOnClick(_ sender: Any) {
        if let url = URL(string: "https://instagram.com/pindavin") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func linkedInButtonOnClick(_ sender: Any) {
        if let url = URL(string: "https://www.linkedin.com/in/davin-djayadi") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
