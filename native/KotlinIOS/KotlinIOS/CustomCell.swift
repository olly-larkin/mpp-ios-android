import UIKit

class CustomCell : UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func setData(time: String, price: String) {
        timeLabel.text = time
        priceLabel.text = price
    }
}
