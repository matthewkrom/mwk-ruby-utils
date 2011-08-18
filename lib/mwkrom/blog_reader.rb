module Mwkrom

  ## Copyright(c) MW Krom LLC, All Rights Reserved
  class BlogReader

    attr_accessor :feed_url, :key, :expires_in

    def use_expires_in
      expires_in || 10.minutes
    end

    def articles_for(tags)
      ActiveSupport::JSON.decode(json_articles_for(tags))
    end

    def json_articles_for(tags)
      tkey = tags.join(":").gsub(' ', '')
      cache_key = "blog_reader_tags:#{tkey}:#{key}"
      Rails.cache.fetch(cache_key, :expires_in => use_expires_in) do
        json_internal_articles_for(tags)
      end
    end

    def json_internal_articles_for(tags)
      internal_articles_for(tags).to_json
    end

    def internal_articles_for(tags)
      d = latest_feed_dom
      if d.blank?  # bad connection; empty data; etc.
        return []
      end
      items = (d/:item).select do |item|
        tags.empty? || ((item/:category).any? {|x| tags.include?(x.inner_text)})
      end
      items.map do |item|
        {:url => item.at('link').inner_html,
          :title => item.at('title').inner_html,
          :pubDate => (item.at('pubDate') && item.at('pubDate').inner_html),
          :creator => (item.at('dc:creator') && item.at('dc:creator').inner_html),
          :description => item.at('description').inner_text}
      end
    end

      def latest_feed_xml
        cache_key = "blog_reader_all:#{key}"
        Rails.cache.fetch(cache_key, :expires_in => use_expires_in) do
          begin
            res = Net::HTTP.get_response(URI.parse(feed_url))
            res && res.body
          rescue Errno::ECONNREFUSED => e
            ""
          end
        end
      end

      def latest_feed_dom
        latest_feed_xml.present? && Hpricot::XML(latest_feed_xml)
      end

    end


  end
