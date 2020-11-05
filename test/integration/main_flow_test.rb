require "test_helper"

class MainFlowTest < ActionDispatch::IntegrationTest
  include ActionCable::TestHelper

  class DummyQuoteSource
    INITIAL_QUOTE = 314

    def initialize
      @val = INITIAL_QUOTE
    end

    def set(val)
      @val = val
    end

    def fetch
      @val
    end
  end

  def setup
    QuoteGuardian.instance.reset
  end

  def teardown
    QuoteGuardian.instance.reset
  end

  def test_regular_update
    source = DummyQuoteSource.new
    broadcaster = QuoteBroadcaster.new(source)

    assert_broadcast_on("quote", DummyQuoteSource::INITIAL_QUOTE) do
      broadcaster.perform
    end

    assert_no_broadcasts("quote") do
      source.set(111)
      broadcaster.perform
    end

    travel_to Time.now + 2.hours do
      assert_broadcast_on("quote", 111) do
        broadcaster.perform
      end
    end
  end

  def test_temprorary
    broadcaster = QuoteBroadcaster.new(DummyQuoteSource.new)

    assert_broadcast_on("quote", DummyQuoteSource::INITIAL_QUOTE) do
      broadcaster.perform
    end

    assert_broadcast_on("quote", 777) do
      post "/admin", params: {
        value: 777,
        expirationDate: Time.now.end_of_day.to_i
      }
      broadcaster.perform
    end

    travel_to Time.now + 1.day do
      assert_broadcast_on("quote", DummyQuoteSource::INITIAL_QUOTE) do
        broadcaster.perform
      end
    end
  end
end
