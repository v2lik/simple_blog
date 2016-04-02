u = User.create(login: 'qwerty', password: 'qwerty')

text = 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit'

20.times do |i|
  p = Post.create(user: u, title: "post title #{i + 1}", body: text)
  Comment.create(user: u, body: "comment-#{i}", post: p)
end
