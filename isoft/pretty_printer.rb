module PrettyPrinter
  def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
  end

  def red(text); colorize(text, "\e[31m"); end
  def green(text); colorize(text, "\e[32m"); end
  def yellow(text); colorize(text, "\e[1m\e[33m");  end
  def console_blink(text); colorize(text, "\e[5m");  end
  def console_bold(text); colorize(text, "\e[1m");  end

  def print_info(msg, centered = false)
    msg = msg.center(terminal_width) if centered
    STDOUT.write green(msg)
  end

  def print_warning(msg, centered = false)
    msg = msg.center(terminal_width) if centered
    STDOUT.write red(msg)
  end

  def print_in(color, msg)
    STDOUT.write self.send(color, msg)
  end
end