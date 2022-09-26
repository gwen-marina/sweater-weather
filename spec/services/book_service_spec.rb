require 'rails_helper'

RSpec.describe BookService do 

  it 'retrieves book data based on a location', :vcr do
    location = 'denver,co'

    books = BookService.get_books(location)
    expect(books).to be_a(Hash)
    expect(books).to have_key(:numFound)
    expect(books).to have_key(:docs)
    expect(books[:docs][0]).to have_key(:isbn)
    expect(books[:docs][0]).to have_key(:title)
    expect(books[:docs][0]).to have_key(:publisher)
  end
end

