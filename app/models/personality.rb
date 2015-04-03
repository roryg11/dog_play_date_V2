class Personality < Filter
  validate :user_cannot_have_more_than_four_personality_filters

  def filter(dogs)
    dogs.where({personality: users_personality_filters.pluck(:content)})
  end

  def users_personality_filters
    user.filters.where({type: "Personality"})
  end

  def self.options
    %w(Confident Independent Laid-Back Shy-Timid Adaptable)
  end

  def user_cannot_have_more_than_four_personality_filters
    if Filter.where(user_id: user_id, type: "Personality").length >= 4
      errors.add(:user_id, "Cannot have more than four personality preferences")
    end
  end
end
