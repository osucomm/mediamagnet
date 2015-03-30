class SkipCache
  def initialize(app)
    @app = app
  end

  def call(env)

    unless (env['REQUEST_URI'] =~ /^\/api\/v/).zero?
      env["rack-cache.force-pass"] = true
    end

    @app.call(env)
  end
end
