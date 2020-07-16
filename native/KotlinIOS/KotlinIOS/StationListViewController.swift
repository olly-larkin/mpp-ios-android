import UIKit

class StationListViewController : UIViewController {
    
    @IBOutlet var stationsTableView: UITableView!
    
    private let stationCellIden = "STATION_CELL_IDEN"

    private var stations: [String] = []
    private var buttonToChange: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }
    
    private func setUpTable() {
        stationsTableView.register(UITableViewCell.self, forCellReuseIdentifier: stationCellIden)
        stationsTableView.tableFooterView = UIView(frame: .zero)
    }
    
    func setData(stations: [String]) {
        self.stations = stations
    }
    
    func setButtonRef(_ button: UIButton) {
        buttonToChange = button
    }
}


extension StationListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stationsTableView.dequeueReusableCell(withIdentifier: stationCellIden)
        cell?.textLabel?.text = stations[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: this
        buttonToChange?.setTitle(stations[indexPath.row], for: .normal)
        self.navigationController?.popViewController(animated: true)
    }
}
