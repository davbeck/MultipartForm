# MultipartForm

A simple way to create multipart form requests in Swift.

## Example

```swift
import MultipartForm

let form = MultipartForm(parts: [
	MultipartForm.Part(name: "a", value: "1"),
	MultipartForm.Part(name: "b", value: "2"),
	MultipartForm.Part(name: "c", data: imageData, filename: "3.png", contentType: "image/png"),
])

var request = URLRequest(url: url)
request.httpMethod = "POST"
request.setValue(form.contentType, forHTTPHeaderField: "Content-Type")

let task = session.uploadTask(with: request, from: form.bodyData)
task.resume()
```

To upload a file in the background, you can write out `form.bodyData` to a file and create an upload task from that.
