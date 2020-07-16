import UIKit

class CustomCell : UITableViewCell {
    
    @IBOutlet var departureTimeLabel: UILabel!
    @IBOutlet var arrivalTimeLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    private let departureText = "Departs: "
    private let arrivalText = "Arrives: "
    
    func setData(departureTime: String, arrivalTime: String, priceInPennies: Int32) {
        departureTimeLabel.text = departureText + departureTime
        arrivalTimeLabel.text = arrivalText + arrivalTime
        priceLabel.text = String(format: "from £%.02f", Double(priceInPennies)/100.0)
    }
}
