module ActiveStorage
  # Representation of a single attachment to a model.
  class Attached::One < Attached
    def blank?
      attachment.blank?
    end
  end
end
