class SkipCache
  def initialize(app)
    @app = app
  end

  def call(env)

    unless env['REQUEST_URI'].match(/^\/api\/v/)
      env["rack-cache.force-pass"] = true
    end

    @app.call(env)
  end
end
