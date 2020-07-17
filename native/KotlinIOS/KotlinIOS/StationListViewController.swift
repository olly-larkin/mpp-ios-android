import UIKit

class StationListViewController : UIViewController {
    
    @IBOutlet var stationsTableView: UITableView!
    @IBOutlet var stationSearchBar: UISearchBar!
    
    private let stationCellIden = "STATION_CELL_IDEN"
    
    private var stations: [String] = []
    private var stationsFiltered: [String] = []
    private var buttonToChange: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        if let cancelButton = stationSearchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.isEnabled = true
        }
    }
    
    private func setUpTable() {
        stationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: stationCellIden)
        stationsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setData(stations: [String]) {
        self.stations = stations
        self.stationsFiltered = stations
    }
    
    func setButtonRef(_ button: UIButton) {
        buttonToChange = button
    }
}


extension StationListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationsFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationsTableView.dequeueReusableCell(withIdentifier: stationCellIden)
        cell?.textLabel?.text = stationsFiltered[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        buttonToChange?.setTitle(stationsFiltered[indexPath.row], for: .normal)
        self.navigationController?.popViewController(animated: true)
    }
}

extension StationListViewController : UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        stationsFiltered = stations.filter { $0.lowercased().hasPrefix(searchText.lowercased()) }
        stationsTableView.reloadData()
    }
}
