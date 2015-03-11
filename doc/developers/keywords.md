Api: Keywords
=============

[Back to API Reference](api.md)

Keywords Index Endpoint
-----------------------
/api/v1/keywords.[json/xml]

### Attributes ###
**bold = required**

* **name**(number) - Internal MM id.
* **display_name**(string) - Globally unique identifier as provided by source system.
* **description**(string) - Absolute URL of item from source system.
* **category**(string) - Absolute URL of item in Media Magnet (defaults to html).

Keywords Show Endpoint
-----------------------
/api/v1/keywords/[name].[json/xml]

### Attributes ###
**bold = required**

* **name**(number) - Internal MM id.
* **display_name**(string) - Globally unique identifier as provided by source system.
* **description**(string) - Absolute URL of item from source system.
* **category**(string) - Absolute URL of item in Media Magnet (defaults to html).
