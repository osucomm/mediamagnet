class Error
  MESSAGES = {
    400 => [
      'Bad Request',
      'Say what? Media Magnet could not understand your request.'
    ],
    403 => [
      'Forbidden',
      "Sorry, but you're not allowed to be here! Move along."
    ],
    404 => [
      'Not Found',
      'Sorry! Media Magnet could not find the page you are looking for.'
    ],
    422 => [
      'Unprocessable Entity',
      "The change you wanted was rejected. Maybe you tried to change something you didn't have access to."
    ],
    500 => [
      'Internal Server Error',
      'Media Magnet has encountered an internal error and cannot continue. Our bad!'
    ],
    503 => [
      'Service Unavailable',
      "Media Magnet is just too busy to process your request. Please try back later."
    ]
  }


  def initialize(code, friendly=false)
    @code = code
    @friendly_message = friendly
  end

  def code
    @code
  end

  def message
    if @friendly_message
      Error::MESSAGES[@code][1] || Error::MESSAGES[@code][0]
    else
      Error::MESSAGES[@code][0]
    end
  end

  def errors
    []
  end
end
