module ApplicationHelper
  def strip_locale_url
    locale=I18n.locale
    request.original_url.sub(/locale=[a-zA-Z]{2}/,'')
  end
end
