import Foundation
import UIKit

class TableHeader: UITableViewHeaderFooterView {
    static let identifier: String = "TableHeader"
    var dateLabel: UILabel!
    var timeLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        dateLabel = UILabel()
        timeLabel = UILabel()
        
        dateLabel.text = "2023.9.27 (금)"
        dateLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.systemGray
        
        timeLabel.text = "오전 10:41"
        timeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        timeLabel.textColor = UIColor.systemGray2
        timeLabel.textAlignment = .center
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
        
        contentView.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
//
#Preview {
    TableHeader(reuseIdentifier: "TableHeader")
}
