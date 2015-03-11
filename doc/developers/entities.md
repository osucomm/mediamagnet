Api: Entities
=============

[Back to API Reference](api.md)

Entities Index Endpoint
-----------------------
/api/v1/entities.[json/xml]

### Attributes ###
**bold = required**

* **id**(number) - Internal MM id.
* **name**(string) - Name of entity.
* description(string) - Description of entity.
* keyword(array) - Array of keyword objects.

Entities Show Endpoint
-----------------------
/api/v1/entities/[name].[json/xml]

### Attributes ###
**bold = required**

* **id**(number) - Internal MM id.
* **name**(string) - Name of entity.
* description(string) - Description of entity.
* keyword(array) - Array of keyword objects.
* mappings(array) - Array of mapping objects. Keys of a mapping are
  tag and keyword.
* contact(object) - Detailed contact information for entity.
* channels(array) - Array of channels objects.
