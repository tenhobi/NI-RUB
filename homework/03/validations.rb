# Requires method `add_arms(*arms)`.
module Validations
  def add_arms(*params)
    new_arms_count = params.flatten.size
    current_arms_count = @arms.size

    if new_arms_count + current_arms_count > 10
      raise 'Whoa, slow down there, cowboy! Robot can take maximum of 10 arms.'
    end

    super
  end
end
