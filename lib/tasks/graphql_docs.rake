# frozen_string_literal: true

namespace :graphql_docs do
  desc "Generate GraphQL docs"
  task generate: :environment do
    directory = ENV["BASE_DIR"] || Rails.root.join("public/docs")
    base_url  = ENV["BASE_URL"] || "/docs"

    puts "Generating GraphQL docs to #{directory}"

    GraphQLDocs.build(
      schema: MinesweeperBackendSchema,
      output_dir: directory,
      base_url: base_url,
      delete_output: false
    )
  end
end
