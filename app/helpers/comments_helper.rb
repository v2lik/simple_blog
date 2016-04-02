module CommentsHelper
  def comments_tree(comments, post)
    comments.map do |comment|
      render(partial: 'comments/comment', locals: { post: post, comment: comment }) + (
        if comment.children.count > 0
          content_tag(
            :div, comments_tree(comment.children, post), class: 'comment-child'
          )
        end
      )
    end.join.html_safe
  end
end
