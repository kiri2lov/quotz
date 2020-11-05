class QuoteChannel < ApplicationCable::Channel
  def subscribed
    stream_from "quote"
  end
end
