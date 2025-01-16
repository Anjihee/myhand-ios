import UIKit

class RankingTableViewCell: UITableViewCell {

    private let rankBackgroundView = UIView()
    private let rankLabel = UILabel()
    private let rankImageView = UIImageView()
    private let departmentLabel = UILabel()
    private let scoreLabel = UILabel()
    private let progressBar = UIProgressView(progressViewStyle: .bar)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Rank Background View 설정
        rankBackgroundView.layer.cornerRadius = 15 // 원 크기 조정
        rankBackgroundView.clipsToBounds = true
        contentView.addSubview(rankBackgroundView)
        rankBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        rankImageView.contentMode = .scaleAspectFit
        contentView.addSubview(rankImageView)
        rankImageView.translatesAutoresizingMaskIntoConstraints = false

        rankLabel.font = UIFont.boldSystemFont(ofSize: 16)
        rankLabel.textAlignment = .center
        rankLabel.textColor = .black
        rankBackgroundView.addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false

        departmentLabel.font = UIFont.systemFont(ofSize: 14)
        departmentLabel.textColor = .black

        scoreLabel.font = UIFont.systemFont(ofSize: 14)
        scoreLabel.textColor = UIColor(red: 1.0, green: 0.36, blue: 0.21, alpha: 1.0) // FF5B35
        scoreLabel.textAlignment = .right

        progressBar.trackTintColor = UIColor(red: 1.0, green: 0.71, blue: 0.64, alpha: 1.0) // FFB4A3
        progressBar.progressTintColor = UIColor(red: 1.0, green: 0.44, blue: 0.31, alpha: 1.0) // FF704F
        progressBar.layer.cornerRadius = 5
        progressBar.clipsToBounds = true

        let containerStackView = UIStackView(arrangedSubviews: [departmentLabel, scoreLabel])
        containerStackView.axis = .horizontal
        containerStackView.spacing = 8
        containerStackView.alignment = .center

        contentView.addSubview(containerStackView)
        contentView.addSubview(progressBar)

        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Rank Background View 제약 조건
            rankBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rankBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            rankBackgroundView.widthAnchor.constraint(equalToConstant: 30),
            rankBackgroundView.heightAnchor.constraint(equalToConstant: 30),

            // Rank Image View 제약 조건 (아이콘)
            rankImageView.centerYAnchor.constraint(equalTo: rankBackgroundView.centerYAnchor),
            rankImageView.centerXAnchor.constraint(equalTo: rankBackgroundView.centerXAnchor),
            rankImageView.widthAnchor.constraint(equalToConstant: 20),
            rankImageView.heightAnchor.constraint(equalToConstant: 20),

            // Rank Label 제약 조건 (숫자)
            rankLabel.centerYAnchor.constraint(equalTo: rankBackgroundView.centerYAnchor),
            rankLabel.centerXAnchor.constraint(equalTo: rankBackgroundView.centerXAnchor),

            // Stack View 제약 조건 (부서명, 점수)
            containerStackView.leadingAnchor.constraint(equalTo: rankBackgroundView.trailingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            // Progress Bar 제약 조건
            progressBar.topAnchor.constraint(equalTo: departmentLabel.bottomAnchor, constant: 8), // 그래프를 부서명 아래 배치
            progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            progressBar.heightAnchor.constraint(equalToConstant: 10),
            progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(rank: Int, department: String, score: Int) {
        // 랭크에 따라 이미지 또는 숫자 표시 및 배경색 설정
        switch rank {
        case 1:
            rankImageView.image = UIImage(named: "rank1")
            rankLabel.isHidden = true
            rankBackgroundView.backgroundColor = UIColor(red: 1.0, green: 0.965, blue: 0.733, alpha: 1.0) // FFF6BB
        case 2:
            rankImageView.image = UIImage(named: "rank2")
            rankLabel.isHidden = true
            rankBackgroundView.backgroundColor = UIColor(red: 0.847, green: 0.847, blue: 0.847, alpha: 1.0) // D8D8D8
        case 3:
            rankImageView.image = UIImage(named: "rank3")
            rankLabel.isHidden = true
            rankBackgroundView.backgroundColor = UIColor(red: 0.941, green: 0.902, blue: 0.765, alpha: 1.0) // F0E6C3
        default:
            rankImageView.image = nil
            rankLabel.isHidden = false
            rankLabel.text = "\(rank)"
            rankBackgroundView.backgroundColor = rank == 4 ? UIColor(red: 1.0, green: 0.36, blue: 0.21, alpha: 1.0) : UIColor(red: 1.0, green: 0.933, blue: 0.933, alpha: 1.0) // FF5B35 or FFEEEE
        }

        departmentLabel.text = department
        scoreLabel.text = "\(score) do"
        progressBar.progress = Float(score) / 5000.0
    }
}
