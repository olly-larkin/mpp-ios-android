import UIKit
import SharedCode

class TicketListViewController : UIViewController {
    
    @IBOutlet var ticketTable: UITableView!
    
    private var ticketList: [TicketOption] = []
    
    private let cellIden = "TICKET_CELL_IDEN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        ticketTable.register(TicketTableViewCell.self, forCellReuseIdentifier: cellIden)
        ticketTable.tableFooterView = UIView(frame: .zero)
    }
    
    func setData(tickets: [TicketOption]) {
        ticketList = tickets
    }
}

extension TicketListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ticketList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ticketTable.dequeueReusableCell(withIdentifier: cellIden) as! TicketTableViewCell
        cell.setData(
            ticket: ticketList[indexPath.row].name,
            passengers: ticketList[indexPath.row].numberOfTickets,
            price: ticketList[indexPath.row].pricingItem.subTotalInPennies
        )
        return cell
    }
}


class TicketTableViewCell : UITableViewCell {
    
    @IBOutlet var ticketLabel: UILabel!
    @IBOutlet var passengersLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func setData(ticket: String, passengers: Int32, price: Int32) {
        ticketLabel.text = ticket
        passengersLabel.text = String(passengers) + " passengers"
        priceLabel.text = String(format: "£%.02f", Double(price)/100.0)
    }
}
