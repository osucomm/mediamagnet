Key Concepts
============

Entities
--------
In Media Magnet, [entities](/entities) represent a group that produces digital
content or manages content distribution channels (web sites, social media
accounts, etc.)

An entity may be a college, academic department, or business unit. It can also
represent looser collections of individuals producing content about similar
themes. An entity _may_ be created for a single person, but this is a rare
circumstance.

An organization is not limited to one entity, and is free to choose a structure
that best represents their content.

**Example:** *The Department of Athletics would be an entity containing various web feeds and social media channels*
**Example:** *The College of Arts and Sciences may be an entity. The Department of Mathematics and the Center for Languages, Literatures, and Culture may also create entities to better organize their content channels.*

- - -

Channels
--------
[Channels](/channels) are the digital communication vehicles published by an
entity. A channel contains individual content items and publishes those items in
a format Media Magnet can understand.

There are seven content sources (or channel types) that can be added to Media
Magnet:

### RSS Feed

Content based on a traditional website that is periodical or regularly updated.
This often takes the form of a blog or news section. Media Magnet requires the
URL of an [RSS](http://en.wikipedia.org/wiki/RSS) feed to make use of this type
of content.

Most popular content management systems such as [Wordpress](http://codex.wordpress.org/WordPress_Feeds)
and [Drupal](https://www.drupal.org/project/views_rss) can produce an RSS feed
out of the box or by using popular plugins.

**Example** *The university newsroom publishes regular news articles on their [website](http://news.osu.edu). The RSS feed can be found [here](http://news.osu.edu/feed.rss).

### Twitter

[Twitter](https://twitter.com) is a popular micro-blogging platform used to post
short status upadtes and messages. Media Magnet will pull in any tweets from
your timeline and any linked images. To add a Twitter channel, you'll need the
account name or handle.

**Example** *[@OhioState](https://twitter.com/OhioState) is the university's main Twitter account. It's handle is "OhioState"*

### Facebook

[Facebook](https://facebook.com)... who doesn't use it? Even Media Magnet has an
account! If you have a Facebook page (not a personal account), Media Magnet can
pull in its content. Simply create a Facebook channel and provide the page name.

**Example** *[The Ohio State Facebook page](https://www.facebook.com/osu) could be added using the page name "osu"*

### Youtube

To make sure we all have access to the latest viral videos, [Youtube](https://youtube.com)
video playlists can be imported into Media Magnet. They will provide the title,
description, and embed code for each video.

To create a Youtube channel, you'll need the playlist ID you would like to add.
Media Magnet will also ask you for permission to access certain parts of the
Google account associated with the playlist.

**Example** *[The Best of Ohio State](https://www.youtube.com/playlist?list=PL85bdQbcuF0RU9XdBT6Icnw-wE2wVK1A7) playlist ID is PL85bdQbcuF0RU9XdBT6Icnw-wE2wVK1A7*

### Instagram

Upload your photos to [Instagram](https://instagram.com), pop on a Kelvin filter,
and boom! Instant Media Magnet selfie sensation. An Instagram channel wiill
pull in the image/video and caption from a post. Adding an Instagram channel
just requires the account name.

**Example** *[The Ohio State Instgram account](https://instagram.com/theohiostateuniversity/) can be imported with the account name "theohiostateuniversity"*

### Events RSS

Media Magnet has a basic level of support for events. Events occur at a specific
time and place. Examples of events include a visiting faculty lecture, theatre
production, or job fair. Recurring events are not currently supported.

You can inform Media Magnet about events by publishing them in an RSS feed. This
is similar to the format of standard RSS, but with a few special extensions for
time and place data. You can add events by providing the feed URL.

### iCal Events

In addition to RSS, Media Magnet can import events from an iCal (iCalendar)
feed. This allows you to use a Microsoft Exchange or Gmail calendar as a source
of events. Note that there are some limitations to this content source. It will
provide less data to Media Magnet than an events RSS feed. You will need the
calendar URL to create an iCal channel.

- - -

Keywords
--------
A universal set of words used based on common university themes. Media Magnet Keywords can be applied to Entities, Channels and content.

- - -

Tags
----
Public hashtags used within content: Like "#gobucks!"
####Pro-tip: Tags can be mapped to Keywords
**Example:** *The public hash-tag "#gobucks" could be mapped to the Keyword "Buckeye Pride" since they both usually connote spirit messaging*
