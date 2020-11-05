import consumer from "./consumer"
consumer.subscriptions.create({ channel: "QuoteChannel" },  {
  received(data) {
    document.getElementById('quote').textContent = data
  }
})
