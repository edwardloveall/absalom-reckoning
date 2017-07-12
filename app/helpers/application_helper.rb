module ApplicationHelper
  def form_error_hint(model)
    if model.errors.any?
      model_key = model.model_name.i18n_key
      error_count = pluralize(model.errors.count, 'error')
      if model.persisted?
        action = 'update'
      else
        action = 'create'
      end
      content_tag(
        :p,
        t("helpers.error.#{model_key}.#{action}", error_count: error_count),
        class: 'error-tip'
      )
    end
  end

  def date_from_day_number(day_number)
    ArDateParser.from_day_number(day_number.to_i)
  end
end
