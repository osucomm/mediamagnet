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
entity. A channel contains individual [content items](#items) and publishes
those items in a format Media Magnet can understand.

There are seven content sources (or channel types) that can be added to Media
Magnet:

### RSS Feed

Content hosted on a traditional website that is periodical or regularly updated.
This often takes the form of a blog or news section. Media Magnet requires the
URL of an [RSS](http://en.wikipedia.org/wiki/RSS) feed to make use of this type
of content.

Most popular content management systems such as [Wordpress](http://codex.wordpress.org/WordPress_Feeds)
and [Drupal](https://www.drupal.org/project/views_rss) can produce an RSS feed
out of the box or by using popular plugins.

**Example** *The university newsroom publishes regular news articles on their [website](http://news.osu.edu). The RSS feed can be found [here](http://news.osu.edu/feed.rss).*

### Twitter

[Twitter](https://twitter.com) is a popular micro-blogging platform used to post
short status upadtes and messages. Media Magnet will pull in any tweets from
your timeline and any linked images. To add a Twitter channel, you'll need the
account name or handle.

**Example** *[@OhioState](https://twitter.com/OhioState) is the university's main Twitter account. It's handle is "OhioState"*

### Facebook

Even Media Magnet is on [Facebook](https://facebook.com)! If you have a Facebook
page (not a personal account), Media Magnet can pull in its content. Simply
create a Facebook channel and provide the page name.

**Example** *[The Ohio State Facebook page](https://www.facebook.com/osu) could be added using the page name "osu"*

### Youtube

To make sure we all have access to the latest viral videos, [Youtube](https://youtube.com)
playlists can be imported into Media Magnet. They will provide the title,
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

Items
-----
[Items](/items) are the beating heart of Media Magnet. An item represents a
single piece of content published in a [channel](#channels). An item could be a
tweet, post, photo, web page, or event. Media Magnet imports items from channels
on a regular basis and stores their normalized content. This allows you to
retrieve items without needing to know their original content.

When items are imported, they are also given [tags](#tags) and
[keywords](#keywords) using tags from the items themselves and from their
channels and entities.

- - -

Keywords
--------
[Keywords](/keywords) are a taxonomy of terms that describe and categorize the
content in an entity, channel, or item. They are a set of [tags](#tags) whose
meaning has been agreed to by content producers using Media Magnet. This
ensures that, for example, content tagged with "althletics" refers to sports at
Ohio State rather than the Department of Athletics or simply the general idea of
participating in sports. Keywords allow editors to express the meaning of their
content and for other users to find content relevant to their interests.

### Categories
Some keywords fall into specific categories. The categories are:

  * [Audience](/keywords?by_category=audience): The intended autdience for the
    content. These are generally cross-discipline groups who have a particular
    affiliation with the university. For example, a content item tagged with the
    "audience-alumni" keyword is intended to be read by alumni. It does not
    indicate that the content is _about_ alumni
  * [College](/keywords?by_category=college): Each college has a keyword that
    indicates the content is related to the college's faculty, students, staff,
    research, or other activities.
  * [Location](/keywords?by_category=location): Implies that the content is
    geogrphically based, or is more relevant to certain locations than others.
  * [Format](/keywords?by_category=format): Describes the media that makes up
    the content. For example, the "photo" keyword indicates that an item is
    photo-heavy.

### Using Keywords

Keywords can be added to entities and channels from within Media Magnet. We
recommend that they have no more than three general keywords. Using too many
keywords will "polute" items with tags that do not necessarily describe the
content.

Items inherit the keywords of their channel and entity. Similarly, channels
inherit their entity's keywords. To apply keywords to an individual item, the
source system will need to contain a tag that matches a keyword. Case does not
matter ("Alumni" and "AlUmNi" will both add the keyword "alumni") but spaces,
dashes, and slashes must be correct.

- - -

Tags
----
Tags are short words or terms used to sort and categorize [content items](#items).
Unlike [Keywords](#keywords), Media Magnet makes no guarantees about the meaning
of a tag. There is also no assumption that content producers use tags in the
same way. Tags are useful for organizing content in ways that do not align with
Media Magnet keywords.

####Pro-tip: Tags can be [mapped](#mapping) to Keywords

The method of tagging an item varies by channel type:

  * RSS: "category" elements in the feed
  * Twitter: Hashtags
  * Facebook: Hashtags
  * Youtube: Tags added to videos during creation
  * Instagram: Hashtags
  * Events RSS: "category" elements in the feed
  * iCal: Not currently supported

**Example:** *The Twitter hashtag "#cats" Would add the tag "cats" to the Media Magnet*

- - -

Mappings
--------
In many cases, it is not desireable to publish keywords as public-facing tags.
So how can we use keywords at the item level? Media Magnet's got you covered!
Entities and channels can map public tags to Media Magnet keywords. When an item
contains a mapped tag, the corresponding keyword will also be applied. Mappings
apply only to items from a given entity or channel, so you can use your existing
tag vocabularies with Media Magnet.

**Example:** *The hashtag "#gobucks" could be mapped to the keyword "Buckeye Pride" since they both usually connote spirit messaging*  
**Example:** *The hashtag "#osunews" could be mapped to the keyword "News"*
