# ✅ iOS TodoList App with Firebase

TodoList 앱은 Firebase와 연동하여 회원가입, 로그인, 할 일 관리 기능을 제공하는 간단한 실습 프로젝트입니다.  
이 앱을 통해 Firebase 인증 및 데이터베이스 활용 방법을 익히고, iOS UI 개발 경험을 쌓을 수 있습니다.  

## 🔍 주요 기능  

| ![Image](https://github.com/user-attachments/assets/32d7ca4d-0a74-41e7-9c1e-c6577b1478a9) | ![Image](https://github.com/user-attachments/assets/3ee9e0df-920a-4ffd-bd7e-742c0d6d4e3f) | ![Image](https://github.com/user-attachments/assets/b687cad8-4ea9-48f7-863a-f54d771e8ec2) |
| :-: | :-: | :-: |
| 로그인 | 회원가입| Todo 생성 |

| ![Image](https://github.com/user-attachments/assets/51d21f47-dfd0-42a4-9d2f-4449a0399ddc) | ![Image](https://github.com/user-attachments/assets/8ecf1719-765b-4c11-8ab4-43eb75cb2caf) | ![Image](https://github.com/user-attachments/assets/a9304930-59c7-44ea-bd7c-1a46ef7cbb62) |
| :-: | :-: | :-: |
| Todo 완료 기능 | Todo 삭제 기능 | 프로필 및 로그아웃 |

## 🎯 상세 기능  

1. **Firebase와 iOS 앱 연결**  
   - Firebase 프로젝트 생성 및 iOS 앱 연동  
   - Firebase SDK 설치 및 `GoogleService-Info.plist` 추가  

2. **회원가입 및 로그인 기능**  
   - Firebase Authentication을 사용하여 이메일/비밀번호 회원가입 및 로그인 구현  
   - Firestore에 사용자 정보 저장  

3. **네비게이션 인터페이스 구현**  
   - `ContainerView`를 이용한 화면 전환 및 네비게이션 컨트롤  

4. **할 일 추가 기능**  
   - `+` 버튼을 눌러 새로운 Todo 아이템 추가  

5. **할 일 삭제 기능**  
   - 아이템을 왼쪽으로 슬라이드하면 `Delete` 버튼 등장  
   - `Delete` 버튼을 눌러 해당 아이템 삭제  

6. **할 일 완료 체크 기능**  
   - 체크박스를 눌러 완료 상태 변경  

7. **프로필 페이지**  
   - 로그인한 사용자의 회원 정보 확인  
   - 로그아웃 기능 제공  

## ⚙️ 개발 환경 및 기술 스택  

### 📱 Front-End  

<img src="https://github.com/user-attachments/assets/9b83cccb-35a5-404b-802e-fff76474aad5" alt="swift" width="70" height="70">

- **Swift**

### 🔥 Firebase  

<img src="https://github.com/user-attachments/assets/73b224bf-bfe9-4d99-8536-817c6841fe1e" alt="firebase" width="70" height="70">

- Firebase Authentication  
- Firebase Firestore  
