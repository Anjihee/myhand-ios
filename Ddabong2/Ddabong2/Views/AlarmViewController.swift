//
//  AlarmViewController.swift
//  Ddabong2
//
//  Created by 이윤주 on 1/15/25.
//

import UIKit
class AlarmViewController:UIViewController{
    // 스크롤뷰 및 뷰 선언
    @IBOutlet weak var scrollView: UIScrollView!
//    var scrollView: UIScrollView!
      var recentView: UIView!
      var oldView: UIView!
    var contentView: UIView!
      // 스택뷰 선언
      var recentStackView: UIStackView!
      var oldStackView: UIStackView!
    
    let viewModel = AlarmViewModel()
    var responseDTO: AlarmResponse?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 스크롤뷰 및 뷰 설정
                recentView = UIView()
                oldView = UIView()
        
        // ViewModel의 데이터 변경 감지
        viewModel.onResponseDtoUpdated = { [weak self] dto in
            guard let self = self, let dto = dto else { return }
            self.responseDTO = dto
            DispatchQueue.main.async {
                self.setupContentView()
                self.setupRecentView()
                self.setupOldView()
                self.addDummyData()
            }
        }
        fetchAllAlarms()
        
    }
    
    func setupContentView() {
           contentView = UIView()
           contentView.translatesAutoresizingMaskIntoConstraints = false
           scrollView.addSubview(contentView)

           NSLayoutConstraint.activate([
               contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
               contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
               contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
               contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
               contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)  // 가로 크기를 고정해야 함
           ])
       }
    
    
    func setupRecentView() {
           recentView = UIView()
           recentView.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(recentView)
           
           NSLayoutConstraint.activate([
               recentView.topAnchor.constraint(equalTo: contentView.topAnchor),
               recentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               recentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
           ])
           
           // 최근 스택뷰 추가
           recentStackView = UIStackView()
           recentStackView.axis = .vertical
           recentStackView.spacing = 20
           recentStackView.alignment = .fill
           recentStackView.distribution = .fill
           recentStackView.translatesAutoresizingMaskIntoConstraints = false
           
           recentView.addSubview(recentStackView)
           
           NSLayoutConstraint.activate([
               recentStackView.topAnchor.constraint(equalTo: recentView.topAnchor, constant: 10),
               recentStackView.leadingAnchor.constraint(equalTo: recentView.leadingAnchor, constant: 30),
               recentStackView.trailingAnchor.constraint(equalTo: recentView.trailingAnchor, constant: -30),
               recentStackView.bottomAnchor.constraint(equalTo: recentView.bottomAnchor, constant: -10)
           ])
       }
       
    
    
    func setupOldView() {
           oldView = UIView()
           oldView.translatesAutoresizingMaskIntoConstraints = false
           contentView.addSubview(oldView)
           
           NSLayoutConstraint.activate([
               oldView.topAnchor.constraint(equalTo: recentView.bottomAnchor, constant: 20),
               oldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               oldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               oldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor) // 마지막 뷰이므로 bottomAnchor 설정
           ])
           
           // 올드 스택뷰 추가
           oldStackView = UIStackView()
           oldStackView.axis = .vertical
           oldStackView.spacing = 20
           oldStackView.alignment = .fill
           oldStackView.distribution = .fill
           oldStackView.translatesAutoresizingMaskIntoConstraints = false
           
           oldView.addSubview(oldStackView)
           
           NSLayoutConstraint.activate([
               oldStackView.topAnchor.constraint(equalTo: oldView.topAnchor, constant: 10),
               oldStackView.leadingAnchor.constraint(equalTo: oldView.leadingAnchor, constant: 30),
               oldStackView.trailingAnchor.constraint(equalTo: oldView.trailingAnchor, constant: -30),
               oldStackView.bottomAnchor.constraint(equalTo: oldView.bottomAnchor, constant: -10)
           ])
       }
    
    func addDummyData() {
        
        print("addDummyData : \(String(describing: responseDTO))")
        
        
        // 최근 알림 헤더 추가 (라벨 + 버튼)
          let recentHeaderView = createHeaderView(title: "최근 알림", action: #selector(recentButtonTapped))
          recentStackView.addArrangedSubview(recentHeaderView)
        
        let recentCnt:Int = responseDTO?.recentAlarmList.count ?? 0
        if recentCnt > 0 {
            // 최근 스택뷰에 더미 데이터 추가
         for idx in 0...(recentCnt-1) {
                let itemView = createItemView(alarm: responseDTO?.recentAlarmList[idx] ?? Alarm.defaultAlarm)
                recentStackView.addArrangedSubview(itemView)
            }
         
        }
        
        
        // 이전 알림 헤더 추가 (라벨 + 버튼)
          let oldHeaderView = createHeaderView(title: "이전 알림", action: #selector(oldButtonTapped))
          oldStackView.addArrangedSubview(oldHeaderView)
      
        let oldCnt:Int = responseDTO?.oldAlarmList.count ?? 0
        if oldCnt > 0{
            // 올드 스택뷰에 더미 데이터 추가
            for idx in 0...(oldCnt-1) {
                let itemView = createItemView(alarm: responseDTO?.oldAlarmList[idx] ?? Alarm.defaultAlarm)
                oldStackView.addArrangedSubview(itemView)
            }
        }
          
       }
       
    func createItemView(alarm:Alarm) -> UIView {
        let itemView = UIView()
        itemView.backgroundColor = UIColor(hex: "ebebeb")
          itemView.translatesAutoresizingMaskIntoConstraints = false
          itemView.heightAnchor.constraint(equalToConstant: 66).isActive = true
            itemView.layer.cornerRadius = 15
         
          // 첫 번째 줄: 이미지 + 2개 라벨을 담을 Horizontal StackView
          let firstRowStackView = UIStackView()
          firstRowStackView.axis = .horizontal
          firstRowStackView.spacing = 8
          firstRowStackView.alignment = .center
          firstRowStackView.distribution = .fill
        // 첫 번째 라벨
        let firstLabel = UILabel()
        // 이미지뷰
        let imageView = UIImageView()
        
        // 공지사항
        if alarm.category == true {
            firstLabel.text = "공지사항"
            imageView.image = UIImage(named: "imgNotice") // 기본 이미지 설정
        }else{
            firstLabel.text = "경험치 획득"
            imageView.image = UIImage(named: "imgExp") // 기본 이미지 설정
        }
          
          imageView.contentMode = .scaleAspectFit
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
          imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true

          
       
          firstLabel.font = UIFont.boldSystemFont(ofSize: 13)
          firstLabel.textColor = .black

          // 두 번째 라벨
          let secondLabel = UILabel()
        secondLabel.text = alarm.createdAt
          secondLabel.font = UIFont.boldSystemFont(ofSize: 13)
        secondLabel.textColor = UIColor(hex: "8e8e8e")

        
        
          // 두 번째 줄 라벨
          let secondRowLabel = UILabel()
        secondRowLabel.text = alarm.title
          secondRowLabel.font = UIFont.systemFont(ofSize: 12)
          secondRowLabel.textColor = .gray
          secondRowLabel.numberOfLines = 1

          // 첫 번째 줄에 요소 추가
          firstRowStackView.addArrangedSubview(imageView)
          firstRowStackView.addArrangedSubview(firstLabel)
          firstRowStackView.addArrangedSubview(secondLabel)

          // 전체 StackView (수직)
          let mainStackView = UIStackView()
          mainStackView.axis = .vertical
          mainStackView.spacing = 4
          mainStackView.alignment = .fill
          mainStackView.distribution = .fillEqually
          mainStackView.translatesAutoresizingMaskIntoConstraints = false

          // 두 개의 행 추가
          mainStackView.addArrangedSubview(firstRowStackView)
          mainStackView.addArrangedSubview(secondRowLabel)

          // itemView에 StackView 추가
          itemView.addSubview(mainStackView)

          // 오토레이아웃 설정
          NSLayoutConstraint.activate([
              mainStackView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 10),
              mainStackView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -10),
              mainStackView.centerYAnchor.constraint(equalTo: itemView.centerYAnchor)
          ])

          return itemView
      }
    
    
    
    func createHeaderView(title: String, action: Selector) -> UIView {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false

        // 라벨 생성
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        // 버튼 생성
        let button = UIButton(type: .system)
        button.setTitle(" ", for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        // 스택뷰 생성 (라벨 + 버튼)
        let stackView = UIStackView(arrangedSubviews: [titleLabel, button])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        containerView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])

        return containerView
    }
    
    
    @objc func recentButtonTapped() {
        print("최근 알림 버튼 클릭")
        // 여기에 원하는 동작 추가
    }

    @objc func oldButtonTapped() {
        print("이전 알림 버튼 클릭")
        // 여기에 원하는 동작 추가
    }

    
    

    func fetchAllAlarms() {
        viewModel.fetchAllAlarms()
    }
    
    
    


}

