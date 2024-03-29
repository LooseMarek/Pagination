# Pagination

![version tag](https://img.shields.io/github/v/tag/LooseMarek/Pagination) ![language](https://img.shields.io/github/languages/top/LooseMarek/Pagination) ![license](https://img.shields.io/github/license/LooseMarek/Pagination)

![build and test workflow](https://github.com/LooseMarek/Pagination/actions/workflows/build_and_test.yml/badge.svg) ![issues](https://img.shields.io/github/issues/LooseMarek/Pagination)

<a href="https://www.buymeacoffee.com/loosemarek" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

Swift package module used to handle server-side pagination.

## Content

- [Installation](#installation)
- [Usage](#usage)
- [Additional settings](#additional-settings)
- [Testing](#testing)
- [Author](#author)

## Installation

### Swift Package Manager

1. In Xcode go to File -> Add Package...
2. In Search or Enter Package URL paste `https://github.com/LooseMarek/Pagination`
3. Dependency Rule -> Version Up to Next Major -> 1.0.0 < 2.0.0
4. Add Package
5. On the pop up screen -> Add Package

## Usage

### Requirements

Both `loadNextPage()` and `setTotalPages(totalPages)` should be called before performing `canLoadNextPage()` check. See: Usage for implementation.

You should call `loadNextPage()` before fetch.

You can set `setTotalPages(totalPages)` in the callback of the initial fetch call.

If the API don't provide `totalPages` in the response but returns total results count and results per fetch, you will need to manually calculate this from those values e.g. `totalPages = totalResults / resultsPerFetch`. 

### Import module on top of your class

```
import Pagination
```

### Initalize pagination

```
let pagination: PaginationProtocol = Pagination()
```

### Use when fetching pagination data

```
func fetch() {
    pagination.loadNextPage()
    yourApiService.fetch(for: pagination.page) { [weak self] (response, error) in
        self?.pagination.finishedLoadingNextPage()
        if let error = error {
            // Handle error
        } else if let response = response {
            self?.pagination.setTotalPages(response.totalPages)
            // Update list and UI
        }
    }
}
```

Which will:

1. Update page number and mark it pending with `loadNextPage()` Note: Need to be called before fetch. First call will set it to page number 1
2. Use `page` from the Pagination module in API fetch method
3. Mark call as done with `finishedLoadingNextPage()` in a callback of the fetch
4. Set total available pages with `setTotalPages(response.totalPages)` if we have response

### Use in your `tableView cellForRowAt`

```
do {
	if (try pagination.canLoadNextPage(at: index, listCount: yourList.count)) {
	    fetch()
	}
	} catch {
		// Handle error
}
```

Which will:

1. Check, if it can perform another fetch. Note: If the `loadNextPage()` and `setTotalPages()` weren't set before that check, it will throw an error
2. Call your fetch method to get another page

## Additional settings

By default Pagination module will allow for the next fetch, if the list will scroll to above 70% of it's content. 
You can change it to a different percentage by using 

```
setPercentageScrollToLoadNextPage(_ percentageScroll: Double)
```

`percentageScroll` value should be greater than 30% (0.3) and less than 100% (1.0). If you will try to set the value bellow or above allowed percentage it will set to 30% and 100% respectively.

## Testing

Module is run with GitHub Actions everytime the new commit is pushed to the remote branch `master`. The testing includes:

- building the project
- running unit tests

You can also do that locally by running below commands in terminal:

Build:

```
xcodebuild -scheme 'Pagination' -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11,OS=15.0' build
```

Test:

```
xcodebuild -scheme 'Pagination' -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 11,OS=15.0' test
```

Note: The commands above are running with iPhone 11 but you can use any iOS devices you like.

## Author

Marek Loose

