Api: Items
==========

Endpoints
--------
/api/v1/items.json
/api/v1/items/[id].json

Item Attributes
-----------------

* **id** - Internal MM id.
* **link** - URL of item from source system.
* **href** - URL of item in Media Magnet.
* **guid** - Globally unique identifier as provided by source system.
* **chtype**
* excerpt - ~140 character 
* content - HTML content associated 

Optional Elements
-----------------

* title - Source systems that 
* description
* links
* assets

Filters
-------

* channel_id
* channel_type
* entity_id
* tags
* **Keyword Categories (i.e., audience=audience-alumni)

Items are abstracted from their source systems to provide a more uniform 
interface to getting at data. Currently all items are guaranteed to have an 
**excerpt** which is 140 characters of plain text, and **content** which is a 
suitably lean html marked up version of the item's entire content. Additionally
all items contain a **link** (canonical URL of the resource), and an **href** 
(permalink to fetch the item from MediaMagnet). The following
elements are available on items based on type:

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


