xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0",
  "xmlns:atom" => "http://www.w3.org/2005/Atom",
  "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml << yield
end
