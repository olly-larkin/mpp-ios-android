import UIKit
import SharedCode

class ViewController: UIViewController {

    private var stationNameList: [String] = []
    
    @IBOutlet var getJourneysButton: UIButton!
    
    @IBOutlet var originButton: UIButton!
    @IBOutlet var destinationButton: UIButton!
    
    private let presenter: ApplicationContractPresenter = ApplicationPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewTaken(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func journeyButtonPress(_ sender: Any) {
        let depart = originButton.currentTitle!
        let dest = destinationButton.currentTitle!
        presenter.loadJourneys(departure: depart, destination: dest)
    }
    
    @IBAction func stationButtonPress(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let stationViewController = storyboard.instantiateViewController(withIdentifier: "STATIONS_VIEW_CONTROLLER") as! StationListViewController
        self.show(stationViewController, sender: self)
        stationViewController.setButtonRef(sender)
        stationViewController.setData(stations: stationNameList)
    }
}

extension ViewController: ApplicationContractView {
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "No Journeys Found", message:
            "Sorry. We couldn't find any journeys for the specified route.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayFares(fares: Fares) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "DISPLAY_JOUNEYS_VIEW_CONTROLLER") as! DisplayJourneysViewController
        self.show(newViewController, sender: self)
        newViewController.setTableData(fares)
    }
    
    func setButtonAvailability(state: Bool) {
        getJourneysButton.isEnabled = state
        print("button goes: ", state)
    }
    
    func updateDropDowns(stationNames: [String]) {
        stationNameList = stationNames
        // TODO: set buttons to available!
    }
}
