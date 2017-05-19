module ApplicationHelper
  def form_error_hint(model)
    if model.errors.any?
      type = model.model_name.human
      error_count = pluralize(model.errors.count, 'error')
      content_tag(
        :p,
        "#{error_count} prevented the #{type} from being saved:",
        class: 'errors'
      )
    end
  end
end
