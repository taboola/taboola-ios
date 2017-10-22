## [1.5.2] - 2017-10-22
### Added
- Video support
## [1.5.1] - 2017-08-30
### Changed
- Notice: As of version 1.5.1 default click handling can be aborted only for organic items. Non-organic item clicks will be always handled by Taboola SDK
- Internal changes in click handling
- Internal changes in widget template
## [1.4.10] - 2017-07-25
### Added
- `forceLegacyWebView` was added as a workaround to a WKWebView bug. Please consult Taboola support or your Taboola account manager before using this workaround.
## [1.4.9] - 2017-06-07
### Fixed
- `isOrgnic` was reported incorrectly on `taboolaViewItemClickHandler` in some cases
## [1.4.8] - 2017-05-17
### Fixed
- Setting logLevel to DEBUG
- Report taboolaDidFailAd when widget loaded with no recommendations
- IDFA issue
