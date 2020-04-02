class Post < ApplicationRecord
  has_one :demand
  has_one :supply

  has_many :followed_posts_references
  has_many :followers, :through => :followed_posts_references, :source => :users

  def self.search(search_params)
    demand_sql = ""
    supply_sql = ""

    search_params.each do |key, v|
      next if key == 'preferred_place' || key == 'preferred_date_time' || key == 'exchange_method'
      if key.include?('demand')
        if key.include?('other')
          demand_sql += " AND demands.#{key.sub('demand_', '')} LIKE '#{v}' "
        else
          demand_sql += " AND demands.#{key.sub('demand_', '')} IS NOT NULL "
        end
      elsif key.include?('supply')
        if key.include?('other')
          supply_sql += " AND supplies.#{key.sub('supply_', '')} LIKE '#{v}' "
        else
          supply_sql += " AND supplies.#{key.sub('supply_', '')} IS NOT NULL "
        end
      end
    end

    self
      .where(open_status: 1)
      .yield_self do |relation|
        exchange_method = search_params['exchange_method']
        search_params['exchange_method'].blank? ? relation : relation.where("exchange_method = '#{exchange_method}'")
      end
      .yield_self do |relation|
        preferred_place = search_params["preferred_place"]
        search_params['preferred_place'].blank? ? relation : relation.where("preferred_place LIKE '#{preferred_place}'")
      end
      .yield_self do |relation|
        preferred_date_time = search_params["preferred_date_time"]
        search_params['preferred_date_time'].blank? ? relation : relation.where("preferred_date_time LIKE '#{preferred_date_time}'")
      end
      .joins("INNER JOIN demands ON demands.post_id = posts.id #{demand_sql}")
      .joins("INNER JOIN supplies ON supplies.post_id = posts.id #{supply_sql}")
  end
end
