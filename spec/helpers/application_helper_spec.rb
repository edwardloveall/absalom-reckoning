require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '#form_error_hint' do
    it 'returns an error paragraph for the model' do
      model = Event.new
      model.validate
      html = <<-HTML.strip_heredoc.strip
        <p class="error-tip">3 errors prevented the event from being created</p>
      HTML

      result = helper.form_error_hint(model)

      expect(result).to eq(html)
    end

    context 'when the model has no errors' do
      it 'returns nothing' do
        model = build(:event)
        model.validate

        result = helper.form_error_hint(model)

        expect(result).to be_nil
      end
    end
  end
end
