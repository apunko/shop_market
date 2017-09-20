module SortableTables
  extend ActiveSupport::Concern

  included do
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
        order("#{self.name.pluralize.downcase}.title #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_key.inspect }")
      end
    }
  end

  class_methods do
    def options_for_select
      order('LOWER(title)').map { |e| [e.title, e.id] }
    end

    def options_for_sorted_by
      [
        ['Title desc', 'title_desc'],
        ['Title ask', 'title_asc']
      ]
    end
  end
end