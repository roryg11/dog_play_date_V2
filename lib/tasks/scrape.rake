namespace :scrape do
  task :parks => :environment do
    park_info
  end


  def scrape_city_links
    page = RestClient.get "http://www.bringfido.com/attraction/parks/"
    page_object = Nokogiri::HTML(page)
    city_links = []
    page_object.css('.top_links').children.css('a').map do |link|
      city_links.push((link.attr('href')))
    end
    city_links
  end

  def scrape_park_links
    park_links = []
    city_links = scrape_city_links
    city_links.each do |city_link|
      park_page = RestClient.get "http://www.bringfido.com#{city_link}"
      park_page_html = Nokogiri::HTML(park_page)
      park_page_html.css(".object_snapshot").css('.info').css('h1').css('a').each do |link|
        park_links.push(link.attr('href'))
      end
    end
    park_links.select {|p| p =~ /attraction/ }
  end

  def park_info
    park_links = scrape_park_links
    park_links.each do |link|
      first_page = RestClient.get "http://www.bringfido.com#{link}"
      first_page_html = Nokogiri::HTML(first_page)
      name = first_page_html.css('.title').css('.anchor')[0].text
      address = (first_page_html.css('.address').text).strip.split("\r\n\t\t\t\r\n\t\t\t").join(", ")
      description = first_page_html.css('.detail_container').css('.body')[0].text.strip.split("\r\n\t\t\t\r\n\t\t\t").join(" ").split("\r\n\r\n\t\t\t").join("").split("\r\n\t\t\t\t")[0..-5].join
      if first_page_html.css('.review_header').css('img') == nil
        rating = first_page_html.css('.review_header').css('img').attr('src').text[-10].to_i
      else
        rating = nil
      end
      Park.create(
        title: name,
        address: address,
        rating: rating,
        description: description,
      )
    end
  end
end
