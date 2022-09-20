//
//  DayCell.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 18/09/2022.
//

import UIKit

class DayCell: UITableViewCell {

    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minText: UILabel!
    @IBOutlet weak var maxText: UILabel!
    @IBOutlet weak var humidityText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        minText.text = "Min"
        maxText.text = "Max"
        humidityText.text = "Humidity"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
