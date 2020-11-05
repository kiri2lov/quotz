class WelcomeController < ApplicationController
  def index
    @quote = QuoteGuardian.instance.value
  end
end
