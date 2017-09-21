class String
  def strip_html_whitespace
    self.tr("\n", ' ').
         gsub(/>\s*</, '><').
         strip
  end
end
