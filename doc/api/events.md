API: Events
===========

Events Index
------------

    /api/[version]/events.[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **start_date**(datetime) - The start date/time
* **item**(object) - This event's [item](items.md)
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
* before - `/api/v1/events.json?after=2015-10-27`

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
* **item**(object) - This event's [item](items.md)
* end_date(datetime) - The end date/time
* location(object) - The location at which this event occurs

#### Location

Indicates the location at which an event takes place

* location(string) - The location. This could be a single line address or a more
  abstract notion of a location. Media Magnet does not currently parse location
  strings provided by source systems
* latatude(float) - The latitude of an event in decimal degrees
* longitude(float) - The longitude of an event in decimal degrees
