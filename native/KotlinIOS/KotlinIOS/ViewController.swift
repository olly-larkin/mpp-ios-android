import UIKit
import SharedCode

class ViewController: UIViewController {

    private var data: [String] = []

    @IBOutlet private var pickerdeparture: UIPickerView!
    @IBOutlet private var pickerdestination: UIPickerView!
    @IBOutlet var getJourneysButton: UIButton!
    
    private let presenter: ApplicationContractPresenter = ApplicationPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerdeparture.dataSource = self
        pickerdeparture.delegate = self
        pickerdestination.dataSource = self
        pickerdestination.delegate = self
        
        presenter.onViewTaken(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func ButtonPress(_ sender: Any) {
        let depart = data[pickerdeparture.selectedRow(inComponent: 0)]
        let dest = data[pickerdestination.selectedRow(inComponent: 0)]
        presenter.loadJourneys(departure: depart, destination: dest)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    internal func pickerView(_ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }

    internal func pickerView(_ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int) -> String? {
        return data[row]
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
        self.navigationController?.isNavigationBarHidden = false
        self.show(newViewController, sender: self)
        newViewController.setTableData(fares)
    }
    
    func setButtonAvailability(state: Bool) {
        getJourneysButton.isEnabled = state
    }
    
    func updateDropDowns(stationNames: [String]) {
        data = stationNames
        pickerdeparture.reloadAllComponents()
        pickerdestination.reloadAllComponents()
    }
}
