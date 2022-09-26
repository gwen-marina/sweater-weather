require 'rails_helper'

RSpec.describe 'Book Request' do 

  it 'returns a list of books in json', :vcr do
    params = { location: "tucson,az", quantity: 5 }

    get '/api/v1/book-search', headers: headers, params: params

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response.status).to_not eq(400)

    book_response = JSON.parse(response.body, symbolize_names: true)
    book = book_response[:data]

    expect(book).to be_a Hash
    expect(book).to have_key(:id)
    expect(book).to have_key(:type)
    expect(book[:type]).to eq("books")

    expect(book).to have_key(:attributes)
    expect(book[:attributes]).to have_key(:destination)
    expect(book[:attributes][:destination]).to eq(params[:location])
    expect(book[:attributes]).to have_key(:forecast)
    expect(book[:attributes][:forecast]).to have_key(:summary)
    expect(book[:attributes][:forecast]).to have_key(:temperature)
    expect(book[:attributes]).to have_key(:total_books_found)
    expect(book[:attributes]).to have_key(:books)
    expect(book[:attributes][:books].count).to eq(params[:quantity])

    book[:attributes][:books].each do |book|
      expect(book).to have_key(:isbn)
      expect(book).to have_key(:title)
      expect(book).to have_key(:publisher)
    end

    expect(book[:attributes]).to_not have_key(:key)
    expect(book[:attributes]).to_not have_key(:type)
    expect(book[:attributes]).to_not have_key(:seed)
    expect(book[:attributes]).to_not have_key(:title_suggest)
    expect(book[:attributes]).to_not have_key(:last_modified)
  end

  it 'returns 404 status if params are not valid', :vcr do
    params = { quantity: 5 }

    get '/api/v1/book-search', headers: headers, params: params

    expect(response.status).to eq(404)
  end

  it "returns an error message if quantity is not valid", :vcr do
    params = { location: "tucson,az"}

    get '/api/v1/book-search', headers: headers, params: params
    book_response = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(book_response).to have_key(:message)
    expect(book_response[:message]).to eq("Invalid Quantity")
  end
end