require 'open-uri'
require 'nokogiri'
require 'readline'

doc = Nokogiri::HTML(URI.open('https://kamigame.jp/umamusume/page/110667391372886023.html'))

umamusumes = []
urls = []
for i in 2..6 do
  umamusumes += doc.search("/html/body/div[2]/div[2]/div[1]/main/kamigame-article-body/article/table[#{i}]/tbody/tr/td[1]/span").map{ |node| node.inner_text.strip}
  urls += doc.search("/html/body/div[2]/div[2]/div[1]/main/kamigame-article-body/article/table[#{i}]/tbody/tr/td[1]/span/a").map{ |node| node[:href]}
end

#ary = [umamusumes, urls].transpose
#links = Hash[*ary.flatten]
#p links

begin
  name = Readline.readline('育成ウマ娘の名前を入力してください． > ')
  doc2 = Nokogiri::HTML(URI.open("https://kamigame.jp" + urls[umamusumes.find_index{|s| s == name}]))
rescue TypeError
  puts "そのウマ娘は実装されていないか存在しません．"
  retry
end


p doc2.title

pp doc2.search("#オグリキャップのイベント選択肢と結果--託された想い").inner_text.strip