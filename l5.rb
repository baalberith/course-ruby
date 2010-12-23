require 'open-uri'

# zadanie 2

class SearchEngine
  
  def initialize
    @links = []
    @words = Hash.new([])
  end
  
  def index(start_page, depth)
    index_aux(start_page + '/', '', depth)
  end
  
  def search(reg_exp)
    pages = []
    words_list = @words.keys
    words_list.each do |word|
      if word =~ reg_exp
        @words[word].each do |page|
          pages << page unless pages.include?(page)
        end
      end
    end
    pages
  end
  
  private
  
  def index_aux(start, page, depth)
    if depth > 0
      begin
        @links << page
        handle = open(start + page)
      rescue
      else
        handle.each_line do |line|
          analyze(line, start + page)
          line.scan(/a href *=".+?"/i).each do |link|
            link = link.gsub(/a href *="/, '').gsub(/"/, '')
            if valid?(link) and not @links.include?(link)
              index_aux(start, link, depth - 1)
            end
          end
        end
      ensure
        handle.close if handle
      end
    end
  end
  
  def valid?(link)
    link !~ /(mailto:|http:|https:|www.).+/i
  end
  
  def analyze(line, page)
      line.gsub(/<\/?[^>]+>/, '').gsub(/&nbsp;/, ' ').scan(/\w+/).each do |word|
        word.downcase!
        @words[word] += [page] unless @words[word].include?(page)
    end
  end
  
end

se = SearchEngine.new
se.index('http://www.ii.uni.wroc.pl/cms', 3)
puts se.search(/lama/i)
