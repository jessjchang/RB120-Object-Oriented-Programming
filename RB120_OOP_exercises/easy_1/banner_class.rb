class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+-#{'-' * (@message.length)}-+"
  end

  def empty_line
    "| #{' ' * (@message.length)} |"
  end

  def message_line
    "| #{@message} |"
  end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+

# Further Exploration
class Banner
  def initialize(message, banner_width='default')
    @message = message
    @banner_width = banner_width
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  attr_reader :banner_width, :message

  def horizontal_rule
    "+#{'-' * (adjusted_banner_width)}+"
  end

  def empty_line
    "|#{' ' * (adjusted_banner_width)}|"
  end

  def message_line
    "|#{message.center(adjusted_banner_width)}|"
  end

  def adjusted_banner_width
    if banner_width == 'default'
      message.length + 2
    elsif banner_width < message.length
      message.length
    else
      banner_width
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 2)
puts banner
# +------------------------------------------+
# |                                          |
# |To boldly go where no one has gone before.|
# |                                          |
# +------------------------------------------+

banner = Banner.new('To boldly go where no one has gone before.', 50)
puts banner
# +--------------------------------------------------+
# |                                                  |
# |    To boldly go where no one has gone before.    |
# |                                                  |
# +--------------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+