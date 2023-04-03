# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#

if Book.any?
  puts "\nSkip Seeding Data\n"
  return
end

# Create Publishers
Publisher.create!(
  [
    { name: 'Paste Magazine' },
    { name: 'Publishers Weekly' },
    { name: 'Graywolf Press' },
    { name: "McSweeney's" }
  ]
)

# Create Authors
Author.create!(
  [
    {
      first_name: 'Joel',
      middle_name: nil,
      last_name: 'Hartse'
    },
    {
      first_name: 'Hannah',
      middle_name: 'P.',
      last_name: 'Templer'
    },
    {
      first_name: 'Marguerite',
      middle_name: 'Z.',
      last_name: 'Duras'
    },
    {
      first_name: 'Kingsley',
      middle_name: nil,
      last_name: 'Amis'
    },
    {
      first_name: 'Fannie',
      middle_name: 'Peters',
      last_name: 'Flagg'
    },
    {
      first_name: 'Camille',
      middle_name: 'Byron',
      last_name: 'Paglia'
    },
    {
      first_name: 'Rainer',
      middle_name: 'Steel',
      last_name: 'Rilke'
    }
  ]
)

# Create Books and assign Publisher
books = [
  {
    title: 'American Elf',
    publication_year: '2004',
    publisher: 'Paste Magazine',
    authors: [
      { first_name: 'Joel', last_name: 'Hartse' },
      { first_name: 'Hannah', last_name: 'Templer' },
      { first_name: 'Marguerite', last_name: 'Duras' }
    ],
    edition: 'Book 2',
    isbn_thirteen: '978-1-891830-85-3',
    price: 1000
  },
  {
    title: 'Cosmoknights',
    publication_year: '2019',
    publisher: 'Publishers Weekly',
    authors: [
      { first_name: 'Kingsley', last_name: 'Amis' }
    ],
    edition: 'Book 1',
    isbn_thirteen: '978-1-60309-454-2',
    price: 2000
  },
  {
    title: 'Essex County',
    publication_year: '1990',
    publisher: 'Graywolf Press',
    authors: [
      { first_name: 'Kingsley', last_name: 'Amis' }
    ],
    edition: nil,
    isbn_thirteen: '978-1-60309-038-4',
    price: 500
  },
  {
    title: 'Hey, Mister (Vol 1)',
    publication_year: '2000',
    publisher: 'Graywolf Press',
    authors: [
      { first_name: 'Fannie', last_name: 'Flagg' },
      { first_name: 'Hannah', last_name: 'Templer' },
      { first_name: 'Camille', last_name: 'Paglia' }
    ],
    edition: 'After School Special',
    isbn_thirteen: '978-1-891830-02-0',
    price: 1200
  },
  {
    title: 'The Underwater Welder',
    publication_year: '2022',
    publisher: "McSweeney's",
    authors: [
      { first_name: 'Rainer', last_name: 'Rilke' }
    ],
    edition: nil,
    isbn_thirteen: '978-1-60309-398-9',
    price: 3000
  }
]

books.each do |book|
  publisher = Publisher.find_by_name(book[:publisher])
  attributes = book.except(:publisher, :authors, :publication_year)

  new_book = Book.new(attributes).tap do |attr|
    attr.publisher = publisher
    attr.publicated_at = "01/01/#{book[:publication_year]}"
  end

  # assign authors
  book[:authors].each do |author_name|
    author = Author.find_by(
      first_name: author_name[:first_name],
      last_name: author_name[:last_name]
    )
    new_book.authors_books.new(author: author)
  end

  new_book.save!
end

puts "\nFinished Seeding of data\n"
