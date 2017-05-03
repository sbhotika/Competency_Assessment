module ApplicationHelper

  def iterable?(object)
    object.respond_to? :each
  end

end
