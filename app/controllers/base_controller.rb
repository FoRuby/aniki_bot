module BaseController
  def image(name)
    File.open(File.join(Rails.root, 'app', 'assets', 'images', name), 'r')
  end

  def render_errors(operation, form_name: 'default', policy_name: 'default')
    errors = []
    errors += operation[:errors] if operation[:errors]
    if operation.failure? && operation[:"contract.#{form_name}"]
      errors << operation[:"contract.#{form_name}"].errors.full_messages
    end
    errors << t('errors.not_found') if operation.failure? && operation[:model].nil?
    errors << t('errors.unauthorized') if operation[:"result.policy.#{policy_name}"]&.failure?
    errors.join("\n")
  end
end