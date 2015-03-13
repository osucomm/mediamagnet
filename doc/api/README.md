API
===

Media Magnet provides a public, RESTful API designed to make it easy to extract
content.

Versioning
----------
The Media Magnet API employs a subset of [semantic versioning](http://semver.org).
This means changes that break backward compatibility will not be introduced
within a major version of the API. Features may be added and bug fixes applied
within a major version as long as they remain backward compatible.

### Breaking changes

Breaking changes are those that:

  * Alter the overall structure of the API
  * Remove API formats
  * Remove data elements
  * Rename data elements
  * Alter the sematics or meaning of a data element
  * Change the structure of existing data elements

Breaking changes do not include:

  * Addition of endpoints
  * Addition of data elements
  * Re-ordering data elements
  * Changes to the data itself
  * Deprecation of data elements

### Supported versions

Media Magnet will generally maintain the current major version of the API and
one previous major version. Once a new major version is released, the previous
version becomes deprecated and the version prior to that may be removed. The
developers will try to give at least six months notice prior to removing an API
version.

Current version: 1  
Previous version: N/A

- - -

Request URL path
----------------

The general structure of an API path is:

    /api/[version]/[endpoint]/[id].[format]?[filter]=[value]

#### Version

The version is specified in the format `v1` where "1" is the desired major
version number. Omitting the version will default to the latest major version.

#### Endpoint / ID

The resource type is the plural form of the desired resource.
The ID of a resource may be either a number or a string depending on the
resource type. To request a list of resources, omit any resource ID from the
path.

#### Format

Format can be one of `json`, `xml`, or `rss`. Media Magnet will render API
results using the format specified. The response structure is similar in JSON
and XML. RSS is only available for the items index action and conforms to the
RSS 2.0 specification. The default format is `json`.

#### Filters

Several endpoints provide filters to narrow the result set. Multiple filters are
separated by an ampersand. Some filters accept multiple values, which can be
added like this: `filter[]=value1&filter[]=value2`.

Multiple filters are combined with an AND relationship. Multiple values in a
single filter are combined using an OR relationship.

**Example** */api/items?tags[]=arts&tags[]=athletics&channel_type=twitter will fetch a list of all items that are from a Twitter channel and are tagged with "arts" or "alumni"*

### Request examples

List of keywords: `/api/keywords`  
List of keywords in XML: `/api/keywords.xml`  
Item 274 in XML from API version 1: `/api/v1/items/274.xml`  
A list of items intended for alumni: `/api/v1/items?audience=audience-alumni`  
Items tagged with academics and news: `/api/items?tags[]=academics&tags[]=news`  
An RSS feed of all items: `/api/items.rss`

- - -

Response Structure
------------------

An API response will consist of a root object with two elements. One element,
called "meta" is an object that contains metadata about the response including
the response code and paging links.

The other element is an object or an array of objects with a name that
corresponds to the type of resource requested.

### Response examples

    # /api/v1/keywords/alumni.json
    {
        "keyword": {
            "display_name": "Alumni",
            "description": "Content about alumni.",
            "name": "alumni",
            "category": null
        },
        "meta": {
            "links": {
                "first_page": null,
                "previous_page": null,
                "self": "https://mediamagnet.osu.edu/api/v1/keywords/alumni",
                "next": null,
                "last": null
            },
            "current_page": 1,
            "total_pages": 1,
            "total_results": 1,
            "response_code": 200
        }
    }

    # /api/v1/keywords.json
    {
        "keywords": [
            {
                "name": "campus-ati",
                "display_name": "ATI Campus",
                "description": "This is a campus",
                "category": "location"
            },
            {
                "name": "academics",
                "display_name": "Academics",
                "description": "The broadest tag for research and scholarship.",
                "category": null
            },
            ...
        ],
        "meta": {
            "links": {
                "first_page": "https://mediamagnet.osu.edu/api/v1/keywords",
                "previous_page": null,
                "self": "http://localhost:3000/api/v1/keywords?page=1",
                "next": "http://localhost:3000/api/v1/keywords?page=2",
                "last": "http://localhost:3000/api/v1/keywords?page=2"
            },
            "current_page": 1,
            "total_pages": 2,
            "total_results": 63,
            "response_code": 200
        }
    }

- - -

Verbosity
---------

Generally, Media Magnet will return a verbose representation of a resource when
requested by ID. This may include partial representations of related resurces.
For example, an entity will include an object for each of its channels.

When a resource is returned in a list or is included as part of another
resource, it it generally displayed with less detailed information.

- - -

Endpoints
---------

The following API endpoints are available:

* [Items](items.md)
* [Events](events.md)
* [Keywords](keywords.md)
* [Channels](channels.md)
* [Entities](entities.md)
