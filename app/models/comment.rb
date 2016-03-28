class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  belongs_to :parent, class_name: 'Comment', foreign_key: :parent_id
  has_many :children, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  validates :body, :user, presence: true
  validates_presence_of :post, unless: :parent_id?
  validates_presence_of :parent, unless: :post_id?

  validate :ancestors

  private

  def ancestors
    errors.add(
      :base, I18n.t('activerecord.errors.models.comment.one_of_ancestors')
    ) if [parent_id, post_id].compact.size == 2
  end
end
