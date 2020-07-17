import UIKit

class TicketTableViewCell : UITableViewCell {
    
    @IBOutlet var ticketLabel: UILabel!
    @IBOutlet var passengersLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func setData(ticket: String, passengers: Int32, price: Int32) {
        ticketLabel.text = ticket
        passengersLabel.text = passengers == 1 ? "1 passenger" : String(passengers) + " passengers"
        priceLabel.text = String(format: "£%.02f", Double(price)/100.0)
    }
}
