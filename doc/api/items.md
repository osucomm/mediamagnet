API: Items
==========

Items Index
-----------

    /api/[version]/items.[json|xml|rss]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **guid**(string) - Globally unique identifier as provided by source system
* **link**(string) - Canonical URL of item from source system
* **href**(string) - Absolute URL of item in Media Magnet (defaults to html)
* **channel_type**(string) - Twitter, Facebook page, Instagram, etc.
* **channel_id**(number) - ID of the channel that produced this item
* **excerpt**(string) - ~140 character title, summary, or excerpt of item
* **content**(string) - HTML content associated  with the item
* **tags**(array of strings) - array of strings with tags
* **keywords**(array of objects) - array of objects representing keywords (name and category)
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit
* description(string) - Used for channel_types that have explicit plain-text 
  descriptions (RSS, Events, YouTube)
* published_at(datetime) - The date this item was published
* source_identifier(string) - An identifier used in the source system
* assets(array of objects) - mime, url, and size for media assets (Instagram 
  Photos/Videos, twitpic, RSS enclosures). **NOTE: YouTube videos are not 
  assets as YouTube does not provide access to the source files**

### Filters

Check out the [items page](/items) for an interactive query builder.

* search - `/api/v1/items.json?search=urban%20meyer`
* entity\_id - `/api/v1/items.json?entity\_id=1`
* channel\_id - `/api/v1/items.json?channel\_id[]=1&channel\_id[]=2`
* channel\_type - `/api/v1/items.xml?channel\_type=twitter`
* tags - `/api/v1/items.json?tags[]=mytag&tags[]=audience-alumni`
* audience - `/api/v1/items.json?audience=audience-alumni`
* location - `/api/v1/items.json?location=campus-lima`
* college - `/api/v1/items.json?college=college-medicine`
* format - `/api/v1/items.json?format=photo`

### RSS

The items index is also available as an RSS feed. This allows easy integration
with feed readers. The item attributes listed above are transformed conform to
the RSS spec.

- - -

Items Show
----------

    /api/[version]/items/[id].[json|xml]

### Attributes

**bold = required**

* **id**(number) - Internal Media Magnet ID
* **guid**(string) - Globally unique identifier as provided by source system
* **link**(string) - Canonical URL of item from source system
* **href**(string) - Absolute URL of item in Media Magnet (defaults to html)
* **channel_type**(string) - Twitter, Facebook page, Instagram, etc.
* **channel_id**(number) - ID of the channel that produced this item
* **excerpt**(string) - ~140 character title, summary, or excerpt of item
* **content**(string) - HTML content associated  with the item
* **tags**(array of strings) - array of strings with tags
* **keywords**(array of objects) - array of objects representing keywords (name and category)
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit
* description(string) - Used for channel_types that have explicit plain-text 
  descriptions (RSS, Events, YouTube)
* published_at(datetime) - The date this item was published
* source_identifier(string) - An identifier used in the source system
* assets(array of objects) - mime, url, and size for media assets (Instagram 
  Photos/Videos, twitpic, RSS enclosures)
* channel(object) - The item's channel
* entity(object) - The item's entity
* links(array of strings) - Any URLs or links included in this item's content
* events(array of objects) - Events associated with this item

- - -

Item attributes by content type
-------------------------------

The following elements are available on items based on type:

<table class="table table-condensed">
  <thead>
    <tr>
        <th>Service</th>
        <th>Excerpt (140 Chars)</th>
        <th>Title</th>
        <th>Description</th>
        <th>Content</th>
        <th>Assets</th>
        <th>Links</th>
        <th>Events</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Events RSS Feed</td>
      <td class="success">Title or Truncated Description</td>
      <td class="warning">*Optional</td>
      <td class="warning">*Optional</td>
      <td class="success">Required</td>
      <td class="warning">Optional</td>
      <td class="warning">Optional</td>
      <td class="success">Required</td>
    </tr>
    <tr>
      <td>Web RSS Feed</td>
      <td class="success">Title or Truncated Description</td>
      <td class="warning">*Optional</td>
      <td class="warning">*Optional</td>
      <td class="success">Required</td>
      <td class="warning">Optional</td>
      <td class="warning">Optional</td>
      <td class="danger">Blank</td>
    </tr>
    <tr>
      <td>Twitter</td>
      <td class="success">Tweet (Plain)</td>
      <td class="danger">Blank</td>
      <td class="success">Tweet (Plain)</td>
      <td class="success">Tweet (Marked Up)</td>
      <td class="warning">Pictures</td>
      <td class="warning">Resolved Links</td>
      <td class="danger">Blank</td>
    </tr>
    <tr>
      <td>Instagram</td>
      <td class="success">Caption or Generated</td>
      <td class="danger">Blank</td>
      <td class="warning">Caption (Plain)</td>
      <td class="success">Caption (Marked Up)</td>
      <td class="success">Picture</td>
      <td class="warning">Resolved Caption Links</td>
      <td class="danger">Blank</td>
    </tr>
    <tr>
      <td>Facebook</td>
      <td class="success">Truncated post or Generated</td>
      <td class="danger">Blank</td>
      <td class="success">Post (Plain)</td>
      <td class="success">Caption (Marked Up)</td>
      <td class="warning">Picture</td>
      <td class="warning">Resolved Post Links</td>
      <td class="danger">Blank</td>
    </tr>
    <tr>
      <td>YouTube</td>
      <td class="success">Truncated Title</td>
      <td class="danger">Blank</td>
      <td class="success">Description</td>
      <td class="success">Video iFrame</td>
      <td class="warning">Video Still</td>
      <td class="warning">Resolved Links from Description</td>
      <td class="danger">Blank</td>
    </tr>
    <tr>
      <td>Fund</td>
      <td class="success">Name</td>
      <td class="danger">Name</td>
      <td class="success">Description</td>
      <td class="success">??</td>
      <td class="danger">Blank</td>
      <td class="danger">Blank</td>
      <td class="danger">Blank</td>
    </tr>
  </tbody>
</table>
