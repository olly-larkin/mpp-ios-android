import UIKit
import SharedCode

class DisplayJourneysViewController: UIViewController {
    
    @IBOutlet var resultsTableView: UITableView!
    
    private let standardCellIden = "CELL_IDENTIFIER"
    
    private var fares: Fares? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        resultsTableView.register(nib, forCellReuseIdentifier: standardCellIden)
        resultsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setTableData(_ fares: Fares) {
        self.fares = fares
        resultsTableView?.reloadData()
    }
}

extension DisplayJourneysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fares!.outboundJourneys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: standardCellIden) as! CustomCell
        if (fares != nil) {
            let time = fares!.outboundJourneys[indexPath.row].departureTime
            let price = fares!.outboundJourneys[indexPath.row].tickets.map { $0.priceInPennies }.min()
            cell.setData(time: time, priceInPennies: price ?? 0)
        }
        return cell
    }
}
