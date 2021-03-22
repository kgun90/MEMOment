# MEMOment

순간을 기록하는 간단 일기장

- 진행기간 : 2020. 11. ~ 2020. 12.
- 사용기술 : Swift, Snapkit, FSCalendar, FittedSheets, Realm


## 서비스 소개
<img src="https://user-images.githubusercontent.com/30033658/111913522-d73ee580-8ab1-11eb-8d53-875f03b4a207.png" width="40%">

- MEMOment(메모먼트)는 순간순간을 기록할 수 있는 한 줄 일기입니다.
- 글쓰기 버튼을 통해 선택한 날짜에 순간을 기록할 수 있습니다.
- 수정 및 삭제가 가능합니다.

## 상세 기능 소개

### 1. 모먼트 조회
<img src="https://user-images.githubusercontent.com/30033658/111913523-d7d77c00-8ab1-11eb-83c8-753b4a445b4b.png" width="40%"> <img src="https://user-images.githubusercontent.com/30033658/111913524-d7d77c00-8ab1-11eb-8a44-a681440997ca.png" width="40%">

- 날짜를 선택하면 해당 날짜의 모먼트들이 시간순으로 정렬되어 표시됩니다.
- 달력에서 모먼트가 있는 날짜는 해당 숫자 밑에 분홍색 점이 표시됩니다.
- 달력 하단의 모먼트 목록을 위로 스와이프하면 전체 모먼트를 볼 수 있습니다.
- 더 많은 모먼트는 아래로 스크롤하여 조회할 수 있습니다.

### 2. 모먼트 작성

<img src="https://user-images.githubusercontent.com/30033658/111913521-d6a64f00-8ab1-11eb-984e-f316ed8167b7.png" width="40%">

- 원하는 내용으로 모먼트를 작성하고 저장할 수 있습니다.
- 작성한 모먼트는 Realm을 통해 로컬에 저장됩니다.
- 줄 바꿈 사용이 가능합니다.

### 2-1. 글 작성
<img src="https://user-images.githubusercontent.com/30033658/111913518-d4dc8b80-8ab1-11eb-819f-a85a5dc148a1.png" width="40%"> <img src="https://user-images.githubusercontent.com/30033658/111913519-d5752200-8ab1-11eb-89e1-ac6a027e4213.png" width="40%">

- 글을 입력하고 작성 버튼을 누르면 Realm에 저장되고 리스트에 반영됩니다.
- 리스트는 작성 시각에 상관 없이 게시글에 설정된 시각 순서로 정렬됩니다.


### 2-2. 글 수정
<img src="https://user-images.githubusercontent.com/30033658/111914028-bd9e9d80-8ab3-11eb-9e23-b465181794ce.png" width="40%">

- 글 목록에서 글을 선택하면, 수정화면으로 이동하고 이때 내용을 바꾸고 작성버튼을 선택시 수정이 반영됩니다.

### 3. 모먼트 삭제
<img src="https://user-images.githubusercontent.com/30033658/111913517-d443f500-8ab1-11eb-9d48-2fbd7a344d40.png" width="40%"> <img src="https://user-images.githubusercontent.com/30033658/111913511-d1e19b00-8ab1-11eb-9452-8e1ff0b5d0dc.png" width="40%">

- 모먼트 목록에서 원하는 모먼트를 길게 누르면 삭제 다이얼로그가 표시됩니다.
- 확인 버튼을 눌러 모먼트를 삭제할 수 있습니다.

