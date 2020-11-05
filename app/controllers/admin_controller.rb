class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create

  def show
    @props = {
      'value': QuoteGuardian.instance.temp_value,
      'expiration-date': QuoteGuardian.instance.expiration_date&.to_i
    }
  end

  def create
    QuoteGuardian.instance.set_temporary_value(
      params.require(:value).to_f,
      Time.at(params.require(:expirationDate).to_i)
    )
    head :ok
  end
end
