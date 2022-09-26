require 'rails_helper'

RSpec.describe BookFacade do

 it 'tests the book facade and returns data', :vcr do
   location = 'tucson,az'

   books = BookFacade.find_books(location)
   expect(books).to be_a(Hash)
   expect(books).to have_key(:numFound)
   expect(books).to have_key(:docs)
   expect(books[:docs][0]).to have_key(:isbn)
   expect(books[:docs][0]).to have_key(:title)
   expect(books[:docs][0]).to have_key(:publisher)
  end
end