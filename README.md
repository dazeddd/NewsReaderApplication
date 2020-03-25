MyRealTrip App Challenge
====================
프로그래머스에서 진행된 앱 개발 챌린지 저장소입니다
-----------------------------------------------

# Screenshot
<div>
<img width="220" alt="스크린샷 2020-03-25 오후 5 58 08" src="https://user-images.githubusercontent.com/59472056/77536835-5cfc7500-6ee0-11ea-89b6-59489fdfbdcc.png">

<img width="220" alt="스크린샷 2020-03-25 오후 5 54 04" src="https://user-images.githubusercontent.com/59472056/77536709-2161ab00-6ee0-11ea-9d64-09ca5b756cde.png">

<img width="220" alt="스크린샷 2020-03-25 오후 5 55 25" src="https://user-images.githubusercontent.com/59472056/77536783-3f2f1000-6ee0-11ea-8921-4c564ee74b1c.png">
</div>

# 외부 라이브러리

pod 'SwiftSoup'
pod 'SnapKit', '~> 5.0.0'

# 어려웠던 점

RSS XML 을 파싱하여 link 태그에서 url 을 가져오는데, 그 url 이 뉴스 원문 사이트로 redirect 되기 전 구글 형식의 url 이라서 
'''
let html = try String(contentsOf: url) 
'''
로 가져올 때 제대로된 html 을 가져오는 경우도 있었고 html 을 못가져오는 경우도 있었습니다. 

그래서 URLSession 이나 WebKit 의 url redirect 를 감지하는 delegate 함수를 통해서 리다이렉트된 후의 url 을 가져오려 했지만 


