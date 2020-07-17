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
        let nib = UINib(nibName: "TicketTableViewCell", bundle: nil)
        ticketTable.register(nib, forCellReuseIdentifier: cellIden)
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
            price: ticketList[indexPath.row].priceInPennies
        )
        return cell
    }
}
