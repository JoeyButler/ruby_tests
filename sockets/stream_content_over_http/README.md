# Stream content over HTTP
The other day I had a co-worker ask if it was possbile to stream a
file download. More specifically parse a static file while it was
being downloaded. Granted in most circumstances these days we have a
nice RESTful to interact with but not all situations are ideal. You may
also been wondering why couldn't we wait to download the whole file, but
in this case let's assume the file hundreds of megabytes and we needed
the data available as soon as possible.

I was pretty interested to dive in and see how this would be possible.
In an ideal situation the data would be already be streamed over http
using chunked transfer encoding. But inside the data is delivered all in
one go like with most requests that download html resources.

One idea that popped into my head was to drop down a level in the
networking stack to TCP and stream the content manually. Rather than
using an http client that would download the entire file in one go, I
decided to create and manage a TCP Socket manaully.

Turns out that approach worked as I expected. I was able to parse the
parts of the xml file in chunks and was able to manipulate the xml on
the fly. This gives us enough control to do a lot of things with the
data, even create an actually streaming api over http.
