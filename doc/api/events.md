API: Events
===========

Events Index
------------

    /api/[version]/events.[json|xml|rss]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **start_date**(datetime) - The start date/time
* **item_id**(number) - Internal Media Magnet ID of this event's item
* **link**(string) - Canonical URL of item from source system
* **href**(string) - Absolute URL of item in Media Magnet (defaults to html)
* **source_identifier**(string) - An identifier used in the source system
* **channel_id**(number) - ID of the channel that produced this event's item
* **excerpt**(string) - ~140 character title, summary, or excerpt of item
* **content**(string) - HTML content associated  with the item
* **tags**(array of strings) - array of strings with tags
* **keywords**(array of objects) - array of objects representing keywords (name and category)
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit
* description(string) - Used for channel types that have explicit plain-text 
  descriptions (RSS, Events, YouTube)
* published_at(datetime) - The date this item was published
* assets(array of objects) - mime, url, and size for media assets (Instagram 
  Photos/Videos, twitpic, RSS enclosures). **NOTE: YouTube videos are not 
  assets as YouTube does not provide access to the source files**
* end_date(datetime) - The end date/time
* location(object) - The location at which this event occurs

#### Location object

Indicates the location at which an event takes place

* location(string) - The location. This could be a single line address or a more
  abstract notion of a location. Media Magnet does not currently parse location
  strings provided by source systems
* latatude(float) - The latitude of an event in decimal degrees
* longitude(float) - The longitude of an event in decimal degrees

### Filters

The events index uses the same filter set as [items](items.md). It also has two
additional parameters that filter by date.

* after - `/api/v1/events.json?after=2015-04-15`
* before - `/api/v1/events.json?before=2015-10-27`

**Note:** The `after` filter defaults to the current time. If you would like to
retrieve past events, simply set `after` to a date in the past.

### RSS

The events index is also available as an RSS feed. This allows easy integration
with feed readers. The event attributes listed above are transformed conform to
the RSS spec with the addition of the [RSS 1.0 Events Module](http://web.resource.org/rss/1.0/modules/event/).

- - -

Events Show
-----------

    /api/[version]/events/[id].[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **start_date**(datetime) - The start date/time
* **item_id**(number) - Internal Media Magnet ID of this event's item
* **link**(string) - Canonical URL of item from source system
* **href**(string) - Absolute URL of item in Media Magnet (defaults to html)
* **source_identifier**(string) - An identifier used in the source system
* **channel_id**(number) - ID of the channel that produced this event's item
* **excerpt**(string) - ~140 character title, summary, or excerpt of item
* **content**(string) - HTML content associated  with the item
* **tags**(array of strings) - array of strings with tags
* **keywords**(array of objects) - array of objects representing keywords (name and category)
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit
* description(string) - Used for channel types that have explicit plain-text 
  descriptions (RSS, Events, YouTube)
* published_at(datetime) - The date this item was published
* assets(array of objects) - mime, url, and size for media assets (Instagram 
  Photos/Videos, twitpic, RSS enclosures). **NOTE: YouTube videos are not 
  assets as YouTube does not provide access to the source files**
* end_date(datetime) - The end date/time
* location(object) - The location at which this event occurs

#### Location object

Indicates the location at which an event takes place

* location(string) - The location. This could be a single line address or a more
  abstract notion of a location. Media Magnet does not currently parse location
  strings provided by source systems
* latatude(float) - The latitude of an event in decimal degrees
* longitude(float) - The longitude of an event in decimal degrees
