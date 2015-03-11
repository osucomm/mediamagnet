Api: Channels
=============

[Back to API Reference](api.md)

Channels Index Endpoint
-----------------------
/api/v1/channels.[json/xml]

### Attributes ###
**bold = required**

* **id**(number) - Internal MM id.
* **name**(string) - Name of channel.
* **service_identifier**(string) - URL of feed or account name for social media.
* **primary(boolean)** - Whether this channel is primary for its entity.
* **entity_id**(integer) - 
* avatar(string) - URL of image for Channel
* url(string) - URL
* keywords(array) - Array of keyword objects.

Channels Show Endpoint
-----------------------
/api/v1/channels/[name].[json/xml]

### Attributes ###
**bold = required**

* **id**(number) - Internal MM id.
* **name**(string) - Name of channel.
* **service_identifier**(string) - URL of feed or account name for social media.
* **primary(boolean)** - Whether this channel is primary for its entity.
* **entity_id**(integer) - 
* avatar(string) - URL of image for Channel
* url(string) - URL
* keywords(array) - Array of keyword objects.
* mappings(array) - Array of mapping objects. Keys of a mapping are
* contact(object) - Detailed contact information for channel.
* entity(object) - Information on entity.
