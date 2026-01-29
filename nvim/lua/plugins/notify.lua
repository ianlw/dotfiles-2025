return {
    "rcarriga/nvim-notify",
        opts = {
    background_colour = "NotifyBackground",
    fps = 30,
    icons = {
      DEBUG = "",
      ERROR = "",
      INFO = "",
      TRACE = "✎",
      WARN = ""
    },
    level = 2,
    minimum_width = 50,
    render = "wrapped-compact",
    stages = "fade",
    time_formats = {
      notification = "%T",
      notification_history = "%FT%T"
    },
    timeout = 1000,
    top_down = false
  }
}

