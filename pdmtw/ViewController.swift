//
//  ViewController.swift
//  pdmtw
//
//  Created by tanto wi on 29/03/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnAdd1: UIButton!
    @IBOutlet weak var txtInput1: UITextField!
    @IBOutlet weak var tableView1: UITableView!
    
    var stringArr = [String]()
    var resultRandom = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd1.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickAddButton(_ sender: Any) {
        if let txt = txtInput1.text, !txt.isEmpty {
            if stringArr.count > 0 && stringArr.contains(txt){
                let errorAlert = UIAlertController(title: "Data sudah ada bos !", message: nil, preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Keluar", style: .cancel, handler: nil)
                DispatchQueue.main.async(execute: {
                    errorAlert.addAction(errorAction)
                    self.present(errorAlert, animated:true, completion: nil)
                })
            } else {
                self.stringArr.insert(txt, at: 0)
                tableView1.beginUpdates()
                tableView1.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
                tableView1.endUpdates()
                
                txtInput1.text = nil
            }
        }
    }
    
    @IBAction func onClickDeleteButton(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView1)
        guard let indexpath = tableView1.indexPathForRow(at: point) else {return}
        stringArr.remove(at: indexpath.row)
        tableView1.beginUpdates()
        tableView1.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .left)
        tableView1.endUpdates()
    }
    
    @IBAction func pickPressed(_ sender: Any) {
        if self.stringArr.count < 2 {
            let errorAlert = UIAlertController(title: "Masukkan setidaknya 2 data ke dalam daftar.", message: nil, preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "Keluar", style: .cancel, handler: nil)
            DispatchQueue.main.async(execute: {
                errorAlert.addAction(errorAction)
                self.present(errorAlert, animated:true, completion: nil)
            })
        } else {
            let controller = storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondViewController
            let alert = UIAlertController(title: "Berapa banyak yang ingin Anda pilih dari daftar?", message: nil, preferredStyle: .alert)
            alert.addTextField { (pickNumber) in
                       pickNumber.placeholder = "Masukkan angka."
                   }
            let action = UIAlertAction(title: "Pilih", style: .default, handler: { (ACTION: UIAlertAction!) in
                
                guard let numPick = alert.textFields?.first?.text else { return }
                let intNumPick = (numPick as NSString).integerValue
                
                if (intNumPick >= self.stringArr.count) || (intNumPick<1) {
                    if(intNumPick<1){
                        let errorAlert = UIAlertController(title: "Enter number bigger than 0", message: nil, preferredStyle: .alert)
                        let errorAction = UIAlertAction(title: "Quit", style: .cancel, handler: nil)
                        DispatchQueue.main.async(execute: {
                            errorAlert.addAction(errorAction)
                            self.present(errorAlert, animated:true, completion: nil)
                        })
                    } else {
                        let errorAlert = UIAlertController(title: "Enter number less than your input in the list", message: nil, preferredStyle: .alert)
                        let errorAction = UIAlertAction(title: "Quit", style: .cancel, handler: nil)
                        DispatchQueue.main.async(execute: {
                            errorAlert.addAction(errorAction)
                            self.present(errorAlert, animated:true, completion: nil)
                        })
                    }
                } else {
                    for index in 0...(intNumPick - 1 ) {
                        let pickValue = self.stringArr.randomElement()!
                        self.resultRandom.insert(pickValue, at: index)
                        if let indexRemove = self.stringArr.firstIndex(of: pickValue) {
                            self.stringArr.remove(at: indexRemove)
                        }
                    }
                    
                    controller.textList = self.resultRandom
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true, completion: nil)
                }
            
            } )
            DispatchQueue.main.async(execute: {
                alert.addAction(action)
                self.present(alert, animated:true)
            })
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stringArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableViewCell", for: indexPath) as? EditTableViewCell else {return UITableViewCell()}
        cell.lblName.text = stringArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

