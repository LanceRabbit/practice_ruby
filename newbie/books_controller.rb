class Book
  has_many :authors

  def main_author
    # 這邊會出現 N+1 query
    authors.where(main_author: true).first

    # 因為已經先 preload 進來, 可以改用 detect 來處理
    # authors.detect {_1.main_author? }
  end
end

class BooksController < API::BaseController
  def index
    books = Book.includes(:author).where(id: params[:id])

    render json: response_json(books)

    private

    def response_json(books)
      books.map do |book|
        {
          id: book.id,
          main_author: book.main_author
        }
      end
    end
  end
end

