//
//  ViewController.swift
//  EcommerceGapsi
//
//  Created by Arlen Peña on 21/06/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
   
    @IBOutlet weak var tblProducts: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblProducts.delegate = self
        tblProducts.dataSource = self
    }

}
extension ViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // if tblProducts === tblProducts{
            let cell = tblProducts.dequeueReusableCell(withIdentifier: "cellList",  for: indexPath) as! TableViewCellProducts
            cell.lblProduct.text = "nombre"
            cell.lblPrice.text = "precio"
        //}
       return cell
    }
    

    
    
}
extension ViewController : UITableViewDelegate{
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

