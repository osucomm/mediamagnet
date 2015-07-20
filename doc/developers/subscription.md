Content Subscription
====================

Media Magnet is capable of consuming content from a variety of sources. These
sources are added by creating [Channels](../key_concepts#channels) which
subscribe to an individual account or feed. Currently, Media Magnet supports the
following formats and services. When a channel is created, content is
automatically pulled in from that feed on a regular interval (currently no more
than 10 minutes).

- - -

RSS
---
Media Magnet can import certain content from traditional web sites. This often
takes the form of a blog or news section. Media Magnet requires the URL of an
[RSS](http://en.wikipedia.org/wiki/RSS) feed to make use of this type of
content.

Most popular content management systems such as [Wordpress](http://codex.wordpress.org/WordPress_Feeds)
and [Drupal](https://www.drupal.org/project/views_rss) can produce an RSS feed
out of the box or by using popular plugins.

To work with Media Magnet, the feed must conform to the
[RSS 2.0 specification](http://cyber.law.harvard.edu/rss/rss.html). For each
`<item>` in the feed, it is assumed that:

  * `<title>` contains the article's title
  * `<description>` contains either the item's content or a brief summary
  * An item must have either a `<title>` or `<description>`
  * `<pubDate>` hold the publication date of the content. The date should
    conform to [RFC 822](https://www.ietf.org/rfc/rfc0822.txt). Ex:
    `Sun, 19 May 2002 15:21:36 GMT`
  * `<link>` is the canonical URL of an HTML representation of the item on the
    originating web site
  * `<guid>` contains a unique identifier for the item that _will not change_
    over time.
  * Each `<category>` element contains a single tag and/or Media Magnet keyword
    machine name describing the item.

Note that the base RSS specification does not permit HTML content within any
element. So, markup must not be included in either the `<description>` or
`<title>`. To work around this limitation, Media Magnet supports the
[RSS Content Module](http://web.resource.org/rss/1.0/modules/content/),
specifically the `<content:encoded>` element. It can contain the full, marked up
text of an article.

If you're using `<content:encoded>`, we suggest you structure each item like
this:

  * `<title>` contains the article's title
  * `<description>` contains a brief summary or excerpt
  * `<content:encoded>` contains the full text, which can including markup. If
    possible this text should omit the title and any styling information.

Media Magnet supports attaching images and other media to an item via the
[Media RSS](http://www.rssboard.org/media-rss) specification. Any valid
`<media:content>` elements will be stored as an asset.

- - -

Events RSS
----------
Media Magnet has a basic level of support for events. Events occur at a specific
time and place. Examples of events include a visiting faculty lecture, theatre
production, or job fair.

You can inform Media Magnet about events by publishing them in an RSS feed. This
is similar to the format of standard RSS, but includes the
[RSS 1.0 Events Module](http://web.resource.org/rss/1.0/modules/event/) for time
and place data.

### Caveats ###

  * There is no notion of repeating event rules for events in this spec. Media 
    Magnet does not currently support repeating events.

- - -

iCalendar
---------
.ics files in the iCalendar format are an alternative method to getting events
information in to Media Magnet. Calendaring systems such as the University Email
Service and Google Calendar both offer the ability to publish calendars in iCal
format.

For Ohio State groups that would like to get events information in to Media
Magnet, but cannot provide an RSS feed, creating a shared public Exchange
calendar is an easy alternative.

### Caveats ###

  * Repeating rules are currently ignored for iCalendar.
  * The iCalendar format itself does support [URLs in objects](https://www.ietf.org/rfc/rfc2445.txt)
    (see 4.8.4.6), however neither Google nor UES supports enabling users to
    add/change those URLs. Effectively, this means users can't provide a URL
    associated with their events.
  * iCalendar channels do not support item tagging

- - -

Twitter
-------
Media Magnet will pull in any tweets from your Twitter timeline and any linked
images. To add a Twitter channel, you'll need the account name or handle.

- - -

Facebook Pages
--------------
If you have a Facebook page (not a personal account), Media Magnet can pull in
its content. Simply create a Facebook channel and provide the page name.

- - -

YouTube Playlists
-----------------
Youtube playlists can be imported into Media Magnet. They will provide the
title, description, and embed code for each video.

To create a Youtube channel, you'll need the playlist ID you would like to add.
Media Magnet will also ask you for permission to access certain parts of the
Google account associated with the playlist.

- - -

Instagram
---------
An Instagram channel wiill pull in the image/video and caption from a post.
Adding an Instagram channel just requires the account name.
