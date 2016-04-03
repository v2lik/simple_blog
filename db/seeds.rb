u = User.create(login: 'qwerty', password: 'qwerty')

text = 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit'

20.times do |i|
  p = Post.create(user: u, title: "post title #{i + 1}", body: text)
  c = Comment.create(user: u, body: "comment-#{i + 1}", post: p)
  Comment.create(user: u, body: "comment for comment-#{i + 1}", parent: c)
end
