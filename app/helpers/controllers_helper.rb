module ControllersHelper
  def full_errors(*objects)
    errors = {}
    objects.each do |object|
      errors["#{object.class.name.downcase}_errors"] = object.errors.full_messages
    end
    errors
  end
end
