//
//  RecipeListTableViewCell.swift
//  Smart Recipe Manager
//
//  Created by Agam on 23/11/24.
//

import UIKit

class RecipeListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeDetail: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(using recipe: Recipe) {
        recipeImage.image = UIImage(named: recipe.thumbnail)
        recipeName.text = recipe.name
        recipeDetail.text = recipe.category + ", " + recipe.nutritionInfo
    }

}
