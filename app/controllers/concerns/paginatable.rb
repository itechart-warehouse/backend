# frozen_string_literal: true

module Concerns
  module Paginatable
    def offset_value
      ((params.fetch(:page, 0).to_i + 1) * default_page_size) - default_page_size
    end

    def default_page_size
      params[:per_page].to_i <= 0 ? 5 : params[:per_page].to_i
    end

    def paginate_collection(collection)
      { collection: collection.offset(offset_value).limit(default_page_size),
        page_data:
          { page: params.fetch(:page, 0), default_page_size: default_page_size,
            pages_count: collection.count, elements_count: collection.count } }
    end
  end
end
