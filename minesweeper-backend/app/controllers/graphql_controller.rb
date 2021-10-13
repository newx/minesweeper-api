class GraphqlController < ApplicationController
  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]

    context = {
      current_user: current_user
    }

    result = MinesweeperBackendSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end

  # FIXME: Migrate this to graphql-auth gem. Currently its getting an error due to incompatible version of graphql-auth gem.
  def current_user
    return nil if authorization_header.blank? || jwt_token.blank?

    data = JWT.decode(jwt_token, jwt_secret_key, true, algorithm: "HS256", verify_jti: true)[0]

    User.find_by(id: data["sub"])
  rescue JWT::VerificationError, JWT::DecodeError => e
    Rails.logger.error "Failed to decode/verify JWT: #{e.class} - #{e}"
  end

  def jwt_secret_key
    @jwt_secret_key ||= Rails.application.credentials.devise[:jwt_secret_key]
  end

  def jwt_token
    authorization_header.split(" ").last if authorization_header
  end

  def authorization_header
    request.headers["Authorization"]
  end
end
