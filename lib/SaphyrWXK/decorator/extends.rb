module SaphyrWXK::Decorator::ActiveRecordExtend
  def decorate_with decorator_class
    define_method :decorate, ->(**options){ decorator_class.new self, **options }
    define_singleton_method :decorate, ->(**options){ all.map{ |record| decorator_class.new record, **options } }
  end

  ActiveRecord::Base.extend self
end

module SaphyrWXK::Decorator::ActionViewBaseExtend
  def assign new_assigns
    @_assigns = new_assigns.each do |key, value|
      instance_variable_set("@#{key}", value.try(:decorate, view_context: self) || value)
    end
  end

  ActionView::Base.prepend self
end
