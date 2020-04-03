class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def get_region
    @region = Timeout::timeout(5) { Net::HTTP.get_response(URI.parse('http://api.hostip.info/country.php?ip=' + request.remote_ip )).body } rescue "JP"
  end

  def switch_locale(&action)
    locale = 'en'
    case @region
    when 'JP'
      locale = 'ja'
    when 'TW'
      locale = 'zh_tw'
    when 'HK'
      locale = 'zh_tw'
    when 'MO'
      locale = 'zh_tw'
    when 'CN'
      locale = 'zh_cn'
    else
      locale = 'en'
    end
    I18n.with_locale(locale, &action)
  end
end
