module ApplicationHelper
  def title
    content_for?(:title) ? yield(:title) : 'Uploadr'
  end
end
