Subscription
============

MediaMagnet is capable of consuming content from a variety of sources. These
sources are added by creating [Channels](../key_concepts#channels) which
subscribe to an individual account or feed. Currently, MM supports the following
formats and services. When a channel is created, content is automatically pulled 
in from that feed on a regular interval (currently no more than 10 minutes).

Events RSS
----------
For website owners that have events system, the 
[RSS 1.0 Events Module](http://web.resource.org/rss/1.0/modules/event/)
is usually an easy format to offer an events feed.

### Caveats ###

* There is no notion of repeating event rules for events in this spec.


iCalendar
---------
.ics files in the iCalendar format are an alternative method to getting events
information in to MediaMagnet. Calendaring systems such as the University Email
Service and Google Calendar both offer

For OSU groups that would like to get events information in to Media Magnet,
but cannot provide an RSS feed, creating a shared public Exchange calendar

### Caveats ###

* Repeating rules are currently ignored for iCalendar.
* iCalendar format itself does support [URLs in
  objects](https://www.ietf.org/rfc/rfc2445.txt) (see 4.8.4.6), however neither
Google nor UES supports enabling users to add/change those URLs. Effectively,
this means users can't provide a URL associated with their events in MM.


RSS
---
Simple RSS feeds. 

[RSS Content Module](http://web.resource.org/rss/1.0/modules/content/)

Instagram
---------

Twitter
-------

YouTube Playlists
-----------------

Facebook Pages
--------------





