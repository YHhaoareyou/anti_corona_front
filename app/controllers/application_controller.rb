class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :get_region

  def get_region
    @region = Rails.configuration.x.maxminddb.lookup(request.remote_ip).country.iso_code
    switch_locale(@region)
  end

  def switch_locale(region)
    locale = :en
    case region
    when 'JP'
      locale = :ja
    when 'TW'
      locale = :zh_tw
    when 'HK'
      locale = :zh_tw
    when 'MO'
      locale = :zh_tw
    when 'CN'
      locale = :zh_cn
    else
      locale = :en
    end
    I18n.locale = locale
  end
end
