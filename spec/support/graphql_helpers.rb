module GraphQLHelpers
  def graphql_request(query, variables: {}, headers: {})
    headers.merge!("Content-type" => "application/json")
    post "/graphql", params: { query: query, variables: variables }.to_json, headers: headers
  end

  def user_auth_headers(user)
    params = { user: { email: user.email, password: user.password } }
    headers = { "ACCEPT" => "application/json" }

    post "/users/sign_in", params: params, headers: headers

    jwt = request.env["warden-jwt_auth.token"]

    { "Authorization" => "Bearer #{jwt}" }
  end

  def response_body
    JSON.parse(response.body)
  end

  def response_errors
    response_body.fetch("errors", [])
  end

  def response_error_messages
    response_errors.map { |e| e["message"] }
  end

  def expect_no_graphql_errors
    if response_errors.any?
      puts "GraphQL errors:"
      response_errors.each do |error|
        puts "-" * 80
        pp error
        puts "-" * 80
      end
    end

    expect(response_errors).to be_empty
  end

  def expect_graphql_error(error_message)
    expect(response_errors).to_not be_blank
    expect(response_error_messages).to include(error_message)
  end
end
