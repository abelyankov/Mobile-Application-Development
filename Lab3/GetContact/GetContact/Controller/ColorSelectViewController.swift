//
//  TagSelectViewController.swift
//  GetContact
//
//  Created by Belyankov Arthur on 3/7/19.
//  Copyright © 2019 KBTU. All rights reserved.
//

import UIKit


protocol ColorSelectViewControllerDelegate: class {
    func didSelectColor(_ color: TagColor)
}


class ColorSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var delegate: ColorSelectViewControllerDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        guard let i = selectedColorIndex else {
            return
        }
        
        let tagColor = allColors[i]
        dismiss(animated: true) {
            self.delegate?.didSelectColor(tagColor)
        }
    }
    
    @IBAction func didTapEditButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var selectedColorIndex: Int?
    
    var allColors: [TagColor] {
        return TagColor.all
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 48, left: 16, bottom: 16, right: 16)
        collectionView.register(TagColorCollecrtionViewCell.self, forCellWithReuseIdentifier: "color")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TagColor.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "color", for: indexPath) as! TagColorCollecrtionViewCell
        cell.tagColor = allColors[indexPath.row]
        cell.isSelected = indexPath.row == selectedColorIndex
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColorIndex = indexPath.row
        collectionView.reloadData()
    }
}
