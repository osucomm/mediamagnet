API: Channels
=============

Channels Index
--------------

    /api/[version]/channels.[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **name**(string) - Name of channel
* **service_identifier**(string) - URL of feed or account name for social media
* **primary(boolean)** - Whether this channel is primary for its entity
* **entity_id**(integer) - Media Magnet ID of this channel's entity
* avatar(string) - URL of image for channel
* url(string) - URL of the home page for this channel
* keywords(array of obects) - Keywords applied to this channel

### Filters

* by\_type - `/api/v1/channels.json?by\_type=twitter`

- - -

Channels Show
-------------

    /api/[version]/channels/[id].[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **name**(string) - Name of channel
* **service_identifier**(string) - URL of feed or account name for social media
* **primary(boolean)** - Whether this channel is primary for its entity
* **entity_id**(integer) - Media Magnet ID of this channel's entity
* avatar(string) - URL of image for channel
* url(string) - URL of the home page for this channel
* keywords(array of objects) - Keywords applied to this channel
* mappings(array of objects) - Mappings applied to this entity. Keys of a
  mapping are tag and keyword
* contact(object) - Detailed contact information for channel
* entity(object) - Information on channel's entity
