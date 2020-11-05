class ApplicationController < ActionController::Base
  def index
    @quote = QuoteProvider.instance.value
  end

  def admin
  end
end
