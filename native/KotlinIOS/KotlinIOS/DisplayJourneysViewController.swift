import UIKit
import SharedCode

class DisplayJourneysViewController: UIViewController {
    
    @IBOutlet var resultsTableView: UITableView!
    
    private let standardCellIden = "CELL_IDENTIFIER"
    
    private var fareList: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        resultsTableView.register(nib, forCellReuseIdentifier: standardCellIden)
        resultsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setTableData(_ fareList: [[String]]) {
        self.fareList = fareList
        resultsTableView?.reloadData()
    }
}

extension DisplayJourneysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fareList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: standardCellIden) as! CustomCell
        cell.setData(time: fareList[indexPath.row][1], price: fareList[indexPath.row][2])
        return cell
    }
}
