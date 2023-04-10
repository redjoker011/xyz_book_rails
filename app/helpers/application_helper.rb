module ApplicationHelper
  # Map book image
  #
  # return default.png by default
  def book_image(book)
    image = book.image
    return image if image.attached?

    'default.png'
  end
end
