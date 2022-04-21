# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      security: [
        {
          api_key: []
        }
      ],
      paths: {},
      servers: [
        {
          url: '{connectionType}//{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            },
            connectionType: {
              default: 'http:',
              enum: ['http:', 'https:']
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          api_key: {
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        }
      }
    }
  }
  
  config.swagger_format = :json
end
