# Workday - Assignment README

> Contents

This repository contains:

1. [The specification](README.md) for the project.
2. [Install](#badge) instructions for using the 


Standard Readme is designed for open source libraries. Although it’s [historically](#background) made for Node and npm projects, it also applies to libraries in other languages and package managers.


## Table of Contents

- [Requirements](#requirements)
- [Install](#install)
- [Libraries](#libraries)
- [Architecture](#architecture)
- [Future Improvements](#futureimprovements)
- [Maintainers](#maintainers)
- [Contribute](#contribute)
- [License](#license)

## Requirements

You have been hired by the Royal Ontario Museum to write an app to display featured content on a large digital display. The display is driven by a device running iOS, so you have chosen to prototype this app on an iOS phone. You are to write a robust application that will query a REST service (defined below) for a series of short media files and play them in the order they are received.
You can complete this challenge in any way that you see fit, as long as it is a robust application that meets the requirements outlined above. Be sure to consider the requirements specific to a museum display. Also: You might want to write some tests.
Please include a short readme explaining the choices you made in completing this assignment. Some questions to consider:
• Why did you use the libraries you chose?
• What architectural pattern have you used in structuring your application?
• Can you think of any obvious improvements to your application, given the time?
• Is it robust to failures?

## Install

This project requires [cocoapods](https://cocoapods.org/). It's important to have the package installed before moving forward.

```sh
$ sudo gem install cocoapods
```

## Libraries

Below is a short justification for some of the libraries used within the project:

[NotificationBannerSwift]() was used for displaying status updates (success, errors etc.)
[Cache]() - Caching responses to HTTP requests.  Speeds up access to the app on restart
[PromiseKit]() - Necessary for method chaining, error encapsulation, and cleaner access to the backend API
[Alamofire]() - A networking library that has become a standard in the iOS community.  Has plugins for PromiseKit to make responses chainable
[Player]() was used to provide a quick and easy wrapper for displaying streaming videos
[Reachability]() for showing network status 
[Hippolyte]() for fast stub mocking - test case write up

In addition to the libraries, I created an extension for parsing Alamofire objects using the Codable protocol into objects.  This was useful in immediately using objects from request calls. 

## Architecture

There were several architectural and design decisions that were made within the application.  A few need explaining as the requirements stated displaying the contents sequentially.

 - Within the application, after pulling all the media ids, there are a couple of additional tasks that were performed after downloading each of the media items individually.  Instead of showing 600 collection view cells, I noticed that there were really only 6 links that were valid, 5 of which were potentially playable.  With this information, I implemented:
 - Data sanitization for pulling media ids
 - Caching for faster repeated access
 - Promises for data access layer to encapsulate errors
 - MVVM to prevent most of the data access logic out of the view controller

## Future Improvements

As the assignment took a little under a day, there are definitely some additional features I would have included:
- I would implement more caching around downloading of files.  Right now, we’re streaming all content.  For large files, this can be problematic
- If there were actually 600 files that needed downloading, I would have used an object pool for the view controller to conserve player resources
- If even more time, I would have used NSOperations for Downloading all the data.  This would have allowed for easier retrying if network connectivity went down, errors, etc.
- Some of the media files took an extremely long time to play.  This was because the files were very large.  I would implement either a progress bar for the download on each cell along with caching for faster subsequent accesses
- Better UI/UX in regards to style and transitions 
- More generic caching to handle all types of cases
- More extensive tests around networking instead of the “happy path”, if the files can actually be accessed, or what type of media has been downloaded

## Maintainers

[@clintonbuie](https://github.com/clintonbuie).

## Contribute

Feel free to dive in! [Open an issue](https://github.com/clintonbuie/workday-solution/issues/new) or submit PRs.

Standard Readme follows the [Contributor Covenant](http://contributor-covenant.org/version/1/3/0/) Code of Conduct.

## License

[MIT](LICENSE) © Clinton Buie