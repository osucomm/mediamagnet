API: Events
===========

Events Index
------------

    /api/[version]/events.[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **item_id**(number) - ID of this event's item
* **start_date**(datetime) - The start date
* end_date(datetime) - Absolute URL 
* location(string) - Location string 
* link(string) - Absolute URL of item from source system.
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit.
* description(string) - Used for channel_types that have explicit plain-text 
  descriptions (RSS, Events, YouTube.)
* content(string) - HTML content of event.

### Filters ###
-------

* **id**(number) - Internal MM id.
* **start_date**(string) - Globally unique identifier as provided by source system.
* **item_id**(number)
* end_date(string) - Absolute URL 
* location(string) - Location string 
* link(string) - Absolute URL of item from source system.
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit.
* description(string) - Used for channel_types that have explicit plain-text 
  descriptions (RSS, Events, YouTube.)
* content(string) - HTML content of event.
* **item**(object) - Item object.
