# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# スクレイピング先のURL
url = 'https://kamigame.jp/umamusume/page/110667391372886023.html'

charset = nil
html = URI.open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

# タイトルを表示
p doc.title

#p doc.css('span.icon_giant').inner_text
#p doc.css('span.icon_giant').css('a')[:href]

"""
umamusumes = doc.search('.icon_giant').map{ |node| node.inner_text.strip}
p umamusumes.length

urls = doc.search('.icon_giant').css('a').map{ |node| node[:href]}
p urls.length
"""

umamusumes = []
urls = []
for i in 2..6 do
  umamusumes += doc.search("/html/body/div[2]/div[2]/div[1]/main/kamigame-article-body/article/table[#{i}]/tbody/tr/td[1]/span").map{ |node| node.inner_text.strip}
  urls += doc.search("/html/body/div[2]/div[2]/div[1]/main/kamigame-article-body/article/table[#{i}]/tbody/tr/td[1]/span/a").map{ |node| node[:href]}
end

p umamusumes
p urls

