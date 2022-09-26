class BookFacade

  class << self

    def find_books(location)
      json = BookService.get_books(location)
    end
  end
end