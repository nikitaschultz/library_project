class Quote
  def Quote.all()
    return[
      "Reading is dreaming with open eyes.",
      "A reader lives a thousand lives before he dies.",
      "Never trust anyone who has not brought a book with them.",
      "Books are a uniquely portable magic.",
      "Reading brings us unknown friends.",
      "Literature is the most agreeable way of ignoring life."
    ]
  end

    def Quote.sample()
      return Quote.all().sample()
    end
end
