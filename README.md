MyRealTrip App Challenge
====================
프로그래머스에서 진행된 iOS 앱 개발 챌린지 저장소입니다
-----------------------------------------------

## Screenshot
<div>
<img width="220" alt="스크린샷 2020-03-26 오전 10 22 39" src="https://user-images.githubusercontent.com/59472056/77600623-d1203280-6f4b-11ea-9d1e-188b034c5ba8.png">
<img width="351" alt="스크린샷 2020-03-26 오전 11 07 17" src="https://user-images.githubusercontent.com/59472056/77602887-fadc5800-6f51-11ea-8c75-af015ce7d320.png">
<img width="220" alt="스크린샷 2020-03-26 오전 11 05 43" src="https://user-images.githubusercontent.com/59472056/77602817-cd8faa00-6f51-11ea-8e69-782c97f65c02.png">
</div>

## 외부 라이브러리

+ pod 'SwiftSoup'
+ pod 'SnapKit', '~> 5.0.0'


## 삽질기

1. RSS XML 을 파싱하여 link 태그에서 url 을 가져오는데 기사 원문 html 을 가져오는 경우도 있었고 html 을 못가져오는 경우도 있었습니다. 
```
let html = try String(contentsOf: url) 
```
html 을 못가져오는 링크의 리다이렉트된 후의 기사 원문 url 로 위 코드를 실행해보았는데
redirect 되기 전 url 로 못가져온 html 은 리다이렉트된 url 로 해도 못가져오는 것을 확인할 수 있었습니다.

이것은 링크 문제가 아니고 그냥 기사 원문 사이트에서 html 수집을 하지 못하게 막아 놓은 것이라는 잠정의 결론을 내렸습니다.

그래서 못가져오는 html 로 인해 뉴스 리스트 테이블에서 내용이 일부 비어있는 셀을 아예 뉴스 아이템 리스트에 더하지 않았습니다.
그렇게 함으로 rss xml 에서 가져오는 뉴스의 갯수는 줄었지만 사용자에게 더 온전한 컨텐츠를 제공할 수 있게 되었습니다.

```
// news detail 이 온전한 경우에만 newsitems 리스트에 더해준다
if (newsItemDetail.description == "" || newsItemDetail.thumnailURL == "") {
    return
}
newsItem = NewsItem(title: self.title, link: self.link, newsDetail: self.newsItemDetail)
newsItems.append(newsItem)
```
2.  파싱 속도 높이기: xml 의 item link 로 가져온 뉴스 링크 html  20개 가량을 클라이언트 측에서 파싱하다 보니 시간이 많이 든다. 
    서버 측에서 미리 파싱한 데이터를  request 로 받아오게 구현한다면 클라이언트에서 더 빨리 데이터를 띄울 수 있을 거 같다. 
     
3.  키워드 추출 알고리즘, 추출한 단어 전처리 (불필요한 문자 제거)

4.  refresh control 액션으로 최신 뉴스 아이템들을 받아올 동안 refresh control 을 움직이게 하고 싶었는데 
여러 모로 테스트해본 결과 refresh control 은 데이터를 받아온 후 endRefreshing 이 호출 될 때에야 움직이는 컨트롤이라는 것을 깨달았다.


## 돌아보며
1. 프로젝트를 진행하며 요구사항을 최대한 만족시키려 노력하였습니다.
2. 여유 시간마다 몰입하여 완성도 있는 어플리케이션을 만들어가는데 만족감을 느꼈습니다.
3. 평소에 시도해보지 않았던 테스트 코드를 작성함으로 코드 변경에 심리적 안정감을 가질 수 있었습니다.
4. 앱 챌린지가 끝나도 개인적으로 기획하고 유지보수하여 배포까지 진행해볼 생각입니다. 

