namespace :dev do
  desc 'Creates sample data for local development'
  task prime: :environment do
    create_events
  end

  def create_events
    events = Tsv.parse(Rails.root.join('lib/data/lotr_events.tsv'))
    events.each do |event|
      date = ArDate.new(date_format(event))
      title = event[:description]
      Event.create(title: title, occurred_on: date)
    end
  end

  def date_format(event)
    string = event[:title].gsub(/T.A. /, '')
    year, day_month = string.split(', ')
    if day_month.nil?
      day_month = '1 January'
    end
    year = year.to_i + 1692
    day, month = day_month.split(' ')
    day = day.to_i
    month = month_map(month)
    { year: year, month: month, day: day }
  end

  def month_map(month_name)
    {
      'January' => 1,
      'February' => 2,
      'March' => 3,
      'April' => 4,
      'May' => 5,
      'June' => 6,
      'July' => 7,
      'August' => 8,
      'September' => 9,
      'October' => 10,
      'November' => 11,
      'December' => 12,
    }[month_name]
  end

  class Tsv
    attr_reader :string

    def self.parse(path)
      new(File.read(path)).parse
    end

    def initialize(string)
      @string = string
    end

    def parse
      lines[1..-1].map do |line|
        fields = line.split(/\t/)
        data = row_headers.zip(fields)
        data.to_h
      end
    end

    def row_headers
      @_headers ||= lines.first.split(/\t/).map(&:to_sym)
    end

    def lines
      string.split(/\n/)
    end
  end
end
