class Size < Filter
  def filter(dogs)
    dogs.where({size: users_size_filters.pluck(:content)})
  end

  def users_size_filters
    user.filters.where({type: "Size"})
  end

  def self.options
    %w(Petite Small Medium Large Extra-Large)
  end
end
