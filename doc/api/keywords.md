API: Keywords
=============

Keywords Index
--------------

    /api/[version]/keywords.[json|xml]

### Attributes

**bold = required**

* **name**(string) - Machine name. Contains only letters and dashes
* **display_name**(string) - Friendly name
* **description**(string) - The definition of this keyword
* **category**(string) - Categories group similar keywords

### Filters

* by\_category - `/api/v1/keywords.json?by_category=location`

- - -

Keywords Show
-------------

    /api/[version]/keywords/[name].[json|xml]

### Attributes

**bold = required**

* **name**(string) - Machine name. Contains only letters and dashes
* **display_name**(string) - Friendly name
* **description**(string) - The definition of this keyword
* **category**(string) - Categories group similar keywords
