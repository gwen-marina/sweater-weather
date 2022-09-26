require 'rails_helper'

RSpec.describe Book do
  data = {
          title: "Rails Around Denver (CO) (Images of Rail)",
          publisher: ["Arcadia Publishing"],
          isbn: ["0738548022","9780738548029"]
          }
  

  book = Book.new(data)

  it 'exists'do
    expect(book).to be_a(Book)
  end

  it 'has attributes' do
    expect(book.title).to eq("Rails Around Denver (CO) (Images of Rail)")
    expect(book.publisher).to eq(["Arcadia Publishing"])
    expect(book.isbn).to eq(["0738548022","9780738548029"])
  end
end

