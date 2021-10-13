# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    include Helpers::Auth

    def initialize(object:, context:, field:)
      @current_user = context[:current_user]

      check_auth!

      super
    end
  end
end
