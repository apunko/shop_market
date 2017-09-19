class Category < ApplicationRecord
  belongs_to :shop
  paginates_per 1
  
  filterrific(
    default_filter_params: { sorted_by: 'title_desc' },
    available_filters: [
      :sorted_by
    ]
  )

  scope :sorted_by, lambda { |sort_key|
    direction = (sort_key =~ /desc$/) ? 'desc' : 'asc'

    case sort_key.to_s
    when /^title_/
      order("categories.title #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Title desc', 'title_desc'],
      ['Title ask', 'title_asc']
    ]
  end
end
