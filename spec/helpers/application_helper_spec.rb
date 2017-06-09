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

  describe '#date_from_day_number' do
    it 'returns an ArDate based on a day number' do
      date = ArDate.new(year: 1, month: 1, day: 1)
      day_number = 1

      result = helper.date_from_day_number(day_number)

      expect(result).to eq(date)
    end
    context 'when day number is a string' do
      it 'returns an ArDate based on a day number' do
        date = ArDate.new(year: 1, month: 1, day: 1)
        day_number = 1.to_s

        result = helper.date_from_day_number(day_number)

        expect(result).to eq(date)
      end
    end
  end
end
