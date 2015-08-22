module BooksHelper

  def build_book_reference(book, pages=[])
    "book://#{book.id}##{pages.join(',')}"
  end

  def get_book_from_reference(book_reference)
    book_id, pages = book_reference.match(/(?:book:\/\/)(\d*)(?:#)(.*$)/).captures
    return [book_id.to_i, pages.split(',')]
  end

  def encrypt_book_reference(book_ref_pattern)
    Base64.urlsafe_encode64(book_ref_pattern)
    #book_ref_pattern.encrypt(:sha, salt: Rails.application.secrets[:secret_key_base])
  end

  def decrypt_book_reference(book_ref_pattern)
    Base64.urlsafe_decode64(book_ref_pattern)
    #book_ref_pattern.decrypt(:sha, salt: Rails.application.secrets[:secret_key_base])
  end

  def book_frame(book_reference)
    content_tag :div, class: 'embed-responsive embed-responsive-4by3' do
      content_tag :iframe, '', src: "/pdfjs/web/viewer.html?file=#{load_book_url(encrypt_book_reference(book_reference))}#page=15", width: "100%", height: "600", frameborder: "0", scrolling: "no", class: 'embed-responsive-item'
    end
  end

  def book_reference_link(reference)
    if reference =~ /^book/
      book_id, pages = get_book_from_reference(reference)
      title = Book.find(book_id).title
      title << " - Pages #{pages.join(',')}" unless pages.blank?
      link_to title, book_url(encrypt_book_reference(reference))
    else
      link_to reference, reference, target: '_blank'
    end
  end
end
