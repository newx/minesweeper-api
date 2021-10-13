module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include Helpers::Auth

    attr_accessor :current_user

    def initialize(object:, context:, field:)
      @current_user = context[:current_user]

      check_auth!

      super
    end
  end
end