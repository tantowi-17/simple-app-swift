//
//  SecondViewController.swift
//  pdmtw
//
//  Created by tanto wi on 29/03/22.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var textList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func resetPressed(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "FirstVC") as! ViewController
        
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }

}


extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell else {return UITableViewCell()}
        cell.lblName.text = textList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
