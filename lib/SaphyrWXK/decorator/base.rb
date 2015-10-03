class SaphyrWXK::Decorator::Base < SimpleDelegator

  def initialize(object, view_context:)
    @view_context = view_context
    super object
  end

  def view
    @view_context
  end
end
