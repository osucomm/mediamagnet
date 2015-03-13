API: Entities
=============

Entities Index
--------------

    /api/[version]/entities.[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **name**(string) - Name of entity
* description(string) - Description of entity
* keyword(array of objects) - Keywords applied to this entity

- - -

Entities Show
-------------

    /api/[version]/entities/[id].[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **name**(string) - Name of entity
* description(string) - Description of entity
* keyword(array of objects) - Keywords applied to this entity
* mappings(array of objects) - Mappings applied to this entity. Keys of a
  mapping are tag and keyword
* contact(object) - Detailed contact information for entity
* channels(array of objects) - Channels managed by this entity
