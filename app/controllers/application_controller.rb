class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :set_locale

  def set_locale
    @region = Rails.configuration.x.maxminddb.lookup(request.remote_ip).country.iso_code

    locale = :en
    case @region
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

    I18n.with_locale locale do
      yield
    end
  end
end
