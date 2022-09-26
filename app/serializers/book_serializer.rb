class BookSerializer 

  class << self 

    def create_book(forecast, books, quantity, location)
      {
        data: 
        {
          id: nil,
          type: 'books',
          attributes: {
            destination: location,
            forecast: {
              summary: forecast[:data][:attributes][:current_weather][:conditions],
              temperature: forecast[:data][:attributes][:current_weather][:temperature]
            },
            total_books_found: books[:numFound],
            books: books[:docs].shift(quantity.to_i).map do |book|
              Book.new(book)
            end
          }
        }
      }
    end
  end
end

