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
end
