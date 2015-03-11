Api: Items
==========

[Back to API Reference](api.md)

Items Index Endpoints
---------------------
/api/v1/items.[json/xml/rss]

### Item Attributes ###
---------------
**bold = required**

* **id**(number) - Internal MM id.
* **guid**(string) - Globally unique identifier as provided by source system.
* **link**(string) - Absolute URL of item from source system.
* **href**(string) - Absolute URL of item in Media Magnet (defaults to html).
* **channel_type**(string) - twitter, facebook page, instagram, etc.
* **channel_id**(number)
* **excerpt**(string) - ~140 character synopsis, title or excerpt of item.
* **content**(string) - HTML content associated  with the item.
* **tags**(array of strings) - array of strings with tags.
* **keywords**(array of objects) - array of objects representing keywords (name and category).
* title(string) - Source systems that have explicit titles will be returned here. This
  may be same as excerpt without 140 character limit.
* description(string) - Used for channel_types that have explicit plain-text 
  descriptions (RSS, Events, YouTube.)
* assets(array of objects) - mime, url, and size for media assets (Instagram 
  Photos/Videos, twitpic, RSS enclosures). **NOTE: YouTube videos are not 
  assets as YouTube does not provide access to the source files.**

### Filters ###
-------

Check out the [items page](/items) for an interactive query builder.

* search - /api/v1/items.json?search=urban%20meyer
* entity_id - /api/v1/items.json?entity_id=1
* channel_id - /api/v1/items.json?channel_id[]=1&channel_id[]2
* channel_type - /api/v1/items.xml?channel_type=twitter
* tags - /api/v1/items.json?tags[]=mytag&tags[]=audience-alumni
* **Keyword Categories (i.e., audience=audience-alumni)


/api/v1/items/[item_id].[json/xml/rss]

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


