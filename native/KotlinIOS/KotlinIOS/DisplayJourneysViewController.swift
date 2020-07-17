import UIKit
import SharedCode

class DisplayJourneysViewController: UIViewController {
    
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet var titleBar: UINavigationItem!
    
    private let standardCellIden = "CELL_IDENTIFIER"
    
    private var fares: Fares? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setUpTable() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        resultsTableView.register(nib, forCellReuseIdentifier: standardCellIden)
        resultsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setTableData(_ fares: Fares) {
        self.fares = fares
        resultsTableView?.reloadData()
        if (fares.outboundJourneys.count != 0) {
            let startStation = fares.outboundJourneys[0].originStation.displayName
            let endStation = fares.outboundJourneys[0].destinationStation.displayName
            titleBar.title = startStation + " - " + endStation
        }
    }
}

extension DisplayJourneysViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fares!.outboundJourneys.count
    }
    
    private func getTime(fromDateTime dateTime: String) -> String {
        return String(dateTime[dateTime.index(dateTime.startIndex, offsetBy: 11)..<dateTime.index(dateTime.startIndex, offsetBy: 16)])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: standardCellIden) as! CustomCell
        if (fares != nil) {
            let fullDepartureTime = fares!.outboundJourneys[indexPath.row].departureTime
            let fullArrivalTime = fares!.outboundJourneys[indexPath.row].arrivalTime
            
            let departureTime = getTime(fromDateTime: fullDepartureTime)
            let arrivalTime = getTime(fromDateTime: fullArrivalTime)
            
            let price = fares!.outboundJourneys[indexPath.row].tickets.map { $0.priceInPennies }.min()
            
            cell.setData(
                departureTime: departureTime,
                arrivalTime: arrivalTime,
                priceInPennies: price ?? 0
            )
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ticketsViewController = storyboard.instantiateViewController(withIdentifier: "TICKETS_VIEW_CONTROLLER") as! TicketListViewController
        self.show(ticketsViewController, sender: self)
        ticketsViewController.setData(tickets: fares!.outboundJourneys[indexPath.row].tickets)
    }
}
