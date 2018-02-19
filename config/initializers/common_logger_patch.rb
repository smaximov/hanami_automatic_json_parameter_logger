# frozen_string_literal: true

module CommonLoggerPatch
  ROUTER_PARSED_BODY = 'router.parsed_body'

  def extract_params(env)
    super.merge(env[ROUTER_PARSED_BODY] || {})
  end
end

Hanami::CommonLogger.prepend CommonLoggerPatch if ENV.key?('PATCH_COMMON_LOGGER')
