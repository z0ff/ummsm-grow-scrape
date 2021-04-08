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
p doc.class

#p doc.css('span.icon_giant').inner_text
#p doc.css('span.icon_giant').css('a')[:href]

umamusumes = doc.search('.icon_giant').map{ |node| node.inner_text.strip}
p umamusumes.length

urls = doc.search('.icon_giant').css('a').map{ |node| node[:href]}
p urls.length

"""
results = []
doc.search('.icon_gialt').each_with_index do |node, i|
    name = node.inner_text
    url = node.css(a)[:href]
    p name
    p url
    results << [name, url]
end
"""