import UIKit

class CustomCell : UITableViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func setData(time: String, priceInPennies: Int32) {
        timeLabel.text = time
        priceLabel.text = String(format: "from £%.02f", Double(priceInPennies)/100.0)
    }
}
