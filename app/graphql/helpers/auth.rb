# frozen_string_literal: true

module Helpers::Auth
  attr_accessor :current_user

  private

  def check_auth!
    unless current_user
      raise GraphQL::ExecutionError, "You are not authorized to perform this action"
    end
  end
end
