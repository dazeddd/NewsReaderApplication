MyRealTrip App Challenge
====================
프로그래머스에서 진행된 iOS 앱 개발 챌린지 저장소입니다
-----------------------------------------------

## Screenshot
<div>
<img width="220" alt="스크린샷 2020-03-25 오후 5 58 08" src="https://user-images.githubusercontent.com/59472056/77536835-5cfc7500-6ee0-11ea-89b6-59489fdfbdcc.png">

<img width="220" alt="스크린샷 2020-03-25 오후 5 54 04" src="https://user-images.githubusercontent.com/59472056/77536709-2161ab00-6ee0-11ea-9d64-09ca5b756cde.png">

<img width="220" alt="스크린샷 2020-03-25 오후 5 55 25" src="https://user-images.githubusercontent.com/59472056/77536783-3f2f1000-6ee0-11ea-8921-4c564ee74b1c.png">
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

2.  키워드 추출 알고리즘, 추출 단어 전처리


## 소회
1. 프로젝트를 진행하며 요구사항을 최대한 만족시키려 노력하였습니다.
2. 여유 시간마다 몰입하여 완성도 있는 어플리케이션을 만들어가는데 만족감을 느꼈습니다.
3. 평소에 시도해보지 않았던 테스트 코드를 작성함으로 코드 변경에 심리적 안정감을 가질 수 있었습니다.
4. 앱 챌린지가 끝나도 개인적으로 기획하고 유지보수하여 배포까지 진행해볼 생각입니다. 

