import UIKit
import SharedCode

class DisplayJourneysViewController: UIViewController {
    
    @IBOutlet var resultsTableView: UITableView!
    
    private let standardCellIden = "CELL_IDENTIFIER"
    
    private var presenter = ApplicationContractPresenter()  // TODO: probs get rid
    private var tableData: [String] = []
    private var fareList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: standardCellIden)
        resultsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    // TODO: check if needed (probably not)
    func setPresenter(_ presenter: ApplicationContractPresenter) {
        self.presenter = presenter
    }
    
    func setTableData(_ fareList: [[String]]) {
        self.fareList = fareList
        tableData = fareList.map { $0[1] }
        resultsTableView?.reloadData()
    }
    
    // TODO: check if needed (probably not)
    private func priceInPounds(_ pennies: Int32) -> String {
        let pounds = Double(pennies) / 100.0
        return String(format: "£%.02f", pounds)
    }
}

extension DisplayJourneysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: standardCellIden)
        cell?.textLabel?.text = tableData[indexPath.row]
        return cell!
    }
}
