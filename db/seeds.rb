100.times do
  post = Post.create  title:       Faker::Company.bs,
                      body:        Faker::Hipster.paragraph
  # 5.times { post.comments.create body: Faker::ChuckNorris.fact } if post.persisted?
end

["Music", "Fashion", "Cars", "Beauty", "Travel", "Design", "Food", "Movies", "Sports", "Technology"]. each do |cat|
  Category.create name: cat
end
