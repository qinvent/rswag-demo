class ApplicationController < ActionController::API

  def authenticate_apis
    return head :unauthorized unless request.headers['Authorization'] == '123456'
  end

  def render_ok(records, options: {})

    if records.is_a?(ActiveRecord::Relation)

      # pagination
      paginated_records, count = handle_pagination(records, options[:count])

      render json: {
        records: paginated_records,
        count: count
      }, status: :ok
    else
      render json: records, status: :ok
    end
  end

  def handle_pagination(records, total_count = nil)
    total_count ||= begin
      count = records.count(:all)
      count = count.sum { |_, v| v } if count.class.name.include?('Hash')
      count
    rescue ActiveRecord::StatementInvalid => e
      model_name.count
    end

    per_page = (params[:per_page].presence || 10).to_i
    page = (params[:page].presence || 1).to_i
    paginated_records = records.limit(per_page).offset(per_page * (page - 1))

    # Note - at this moment, the client app can not fetch the headers
    # We are expecting this to be solved sooner
    response.set_header('X-Total-Count', total_count)

    # Currently - this is a workaround
    [paginated_records, total_count]
  end
end
