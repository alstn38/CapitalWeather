# 🌍 CapitalWeather - 전세계 수도의 실시간 날씨

**CapitalWeather**는 전세계 수도의 실시간 날씨를 확인할 수 있는 앱입니다. 

현재 날씨부터 날씨 정보까지, 검색을 통해 원하는 도시에 대한 날씨를 간편하게 확인할 수 있어요. ⛅

**CapitalWeather**와 함께 세계 실시간 날씨를 확인해보세요! 🌤️

<br>

# 주요 기능

### **🌤️ 디테일 날씨 화면**

|   디테일 날씨 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/e5dadb6f-8f0e-4997-96f5-b270e316716d"> | 

- 선택한 도시의 **날짜 정보**와 **날씨 정보**를 확인할 수 있습니다.
- **현재 기온**, **최고/최저 기온**, **체감 온도**를 확인할 수 있습니다.
- **일출/일몰 시간**을 확인할 수 있습니다.
- **습도**, **풍속**을 확인할 수 있습니다.
- 날씨에 맞는 **사진**을 볼 수 있습니다.

<br>

### 🔍 도시 검색 화면

|   도시 검색 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/22b18f11-b154-43e0-a0a4-01d2ac14db3c"> | 


- 주요 도시에 대한 **현재 날씨**를 바로 볼 수 있습니다.
- **검색 기능**을 통해 원하는 도시에 대한 날씨 정보를 확인할 수 있습니다.

<br>

# 🎯 앱 기술 설명

### Alamofire Network Layer

- Router 패턴과 싱글톤을 활용하여 재사용 가능한 Request 메서드를 구현했습니다.
- OpenWeatherAPI, UnsplashAPI의 사용을 추상화고 각 API에 맞는 에러 타입을 정의하고 사용자에게 피드백을 줄 수 있도록 했습니다.


### Entity와 DTO 분리

- 서버 변경에 유연하게 대응할 수 있도록 Entity Model과 DTO Model을 분리하여 설계했습니다.
- 이를 통해 유지보수가 용이하고 확장성이 좋은 구조를 만들었습니다.


### 사용자 UX 경험 향상을 위한 고민

- 사용자의 입력에 공백, 소문자와 같은 처리를 통해 원하는 검색 결과를 얻도록 했습니다.
- 검색 결과가 없을 경우 사용자에게 결과가 없다는 것을 명시적으로 피드백했습니다.
- 메인화면에서 날씨 정보 중 중요한 표현해 관하여 Bold Font로 변경하여 사용자에게 직관적인 정보를 제공했습니다.


### UI에 대한 고민

- 메인 화면에서 메시지 화면과 같은 정보를 표현하기 위해 5개의 정보 타입으로 추상화 하였고, 이것을 통해 Cell이 동적으로 보이도록 설정했습니다.


### 서비스 분리 및 의존성 주입

- NetworkService와 LocalService의 객체를 생성하고 분리하였고, 각 객체에 맞는 인터페이스를 정의하고 의존성 주입을 통해 유지보수를 용이하게 만들었습니다.


<br>

# 🛠 앱 기술 스택

- ****Architecture***: MVVM (Custom Observable 정의)
- ****UI Framework***: UIKit
- ****Data Persistence***: UserDefaults
- ****External dependency***: Alamofire, Kingfisher, SnapKit


<br>

# 🎯 개발 환경

![iOS](https://img.shields.io/badge/iOS-16%2B-000000?style=for-the-badge&logo=apple&logoColor=white)

![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)

![Xcode](https://img.shields.io/badge/Xcode-16.2-1575F9?style=for-the-badge&logo=Xcode&logoColor=white)

<br>

# 📅 개발 정보

- ****개발 기간***: 2025.02.13 ~ 2025.02.17
- ****개발인원***: 1명
- ****사용한 API***:  OpenWeather API, Unsplash API
