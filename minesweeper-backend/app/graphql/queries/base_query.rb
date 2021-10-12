module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    attr_accessor :current_user

    def initialize(object:, context:, field:)
      @current_user = context[:current_user]

      check_authorization!

      super
    end

    private

    def check_authorization!
      unless current_user
        raise GraphQL::ExecutionError, 'You are not authorized to perform this action'
      end
    end
  end
end