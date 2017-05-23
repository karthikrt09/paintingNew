//
//  ViewController.swift
//  paintingCollector
//
//  Created by Karthik Thirunavukkarasan on 5/12/17.
//  Copyright © 2017 Karthik Thiru. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
        @IBOutlet weak var tableView: UITableView!
    
    var paints: [Paint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            paints = try context.fetch(Paint.fetchRequest())
            tableView.reloadData()
        } catch{
    }
        
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let paint = paints[indexPath.row]
        cell.textLabel?.text = paint.title
        cell.imageView?.image = UIImage(data: paint.image as! Data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let paint = paints[indexPath.row]
        performSegue(withIdentifier: "paintSegue", sender: paint)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! PaintingViewController
        nextVC.paint1 = sender as? Paint
    }
    
    
}
