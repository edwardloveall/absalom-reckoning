module ApplicationHelper
  def form_error_hint(model)
    if model.errors.any?
      model_key = model.model_name.i18n_key
      error_count = pluralize(model.errors.count, 'error')
      action = model.persisted? ? 'update' : 'create'
      content_tag(
        :p,
        t("helpers.error.#{model_key}.#{action}", error_count: error_count),
        class: 'error-tip'
      )
    end
  end
end
