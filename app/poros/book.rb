class Book
  attr_reader :title,
              :publisher,
              :isbn

  def initialize(data)
    @title = data[:title]
    @publisher = data[:publisher]
    @isbn = data[:isbn]
  end
end

