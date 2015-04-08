Media Magnet
============

Co-ordinating digital media.

Dependencies
------------

  * Ruby 2.1.4
  * Git
  * Bundler
  * ElasticSearch

Development Installation
------------------------

Ensure you have all of the dependencies listed above. Then clone the project and
install the required gems:

    $ git clone https://code.osu.edu/ucom/mediamagnet.git
    $ cd mediamagnet
    $ bundle install

Create your `.env` file to set up the local environment from the example and
fill in the various service credentials:

    $ cp .env.example .env
    $ vi .env

Next, create the database schema and the ElasticSearch index:

    $ bundle exec rake db:migrate
    $ bundle exec rake items:es_rebuild

Finally populate keywords from production and some initial seed data:

    $ bundle exec rake keywords:import_from_mm
    $ bundle exec rake db:seed

Run Locally
-----------

Media Magnet can be run using the Rails web server.

    $ bundle exec rails s

Then open your browser to `http://localhost:3000`.
