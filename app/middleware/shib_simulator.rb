class ShibSimulator
  def initialize(app)
    @app = app
    @vars = ENV.key?('SHIB_SIM') ? ENV['SHIB_SIM'].split(';') : []
  end

  def call(env)
    @vars.each do |var|
      env[var] = ENV[ 'SHIB_SIM_' + var.upcase.gsub('-', '_') ]
    end

    @app.call(env)
  end
end
