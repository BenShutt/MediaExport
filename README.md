# Media Export

A SwiftUI iOS app that syncs media on the device (images, videos, etc) with a server over the WIFI.

It is written as client for a [C-Server](https://github.com/BenShutt/C-Playground/tree/develop/Server) project that I worked on for learning purposes. It is merely a developer-tool and not to be used for anything more.

## File Names

Quite a few media files had duplicate [originalFilename](https://developer.apple.com/documentation/photokit/phassetresource/1623985-originalfilename) values. Ideally, we'd fallback to using [localIdentifier](https://developer.apple.com/documentation/photokit/phobject/1622400-localidentifier) to construct a unique file name, but this property represents a file path (i.e. might contain parent directories).
The solution was to hash the `localIdentifier` with [SHA256](https://developer.apple.com/documentation/cryptokit/sha256) taking only the first 8 characters (assuming this is enough). This ID is then prefixed before the `originalFilename`.

## PHAsset Data

Getting the binary data to upload for a [PHAsset](https://developer.apple.com/documentation/photokit/phasset) seemed to be a finicky, convoluted process.
For images, [requestImageDataAndOrientation(for:options:resultHandler:)](https://developer.apple.com/documentation/photokit/phimagemanager/3237282-requestimagedataandorientation) seemed to work without too much trouble. 
For videos though, since an [AVURLAsset](https://developer.apple.com/documentation/avfoundation/avurlasset) is not guaranteed, we were required to use [requestExportSession(forVideo:options:exportPreset:resultHandler:)](https://developer.apple.com/documentation/photokit/phimagemanager/1616981-requestexportsession) and write to a temporary file. For both, various request options needed to be set.
The logic for each is encapsulated in `ImageFetcher` and `VideoFetcher` respectively.

A part of the complexity may come from `PHAsset`s sometimes having more than one [PHAssetResource](https://developer.apple.com/documentation/photokit/phassetresource) but are assumed to be a single file (that we send to the server).

It is assumed that the first `PHAssetResource` of a `PHAsset` contains the (original) file name.

## Credits

* [Picture icons created by Freepik - Flaticon](https://www.flaticon.com/free-icons/picture)
* [Colors from Pintrest](https://www.pinterest.co.uk/pin/304626362308735903/)
