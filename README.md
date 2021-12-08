# Swift Base Project

## Overview
Codebase to serve as a template for future projects. Contains the ff. project files, structure, and capabilities (all with sample implementation):

* Base API client.
  * Initial set of endponts.
* Codable structs for API-related response and requests.
* Initial Login to Main screen setup:
  * Handle basic form validation.
  * Process indicator.
  * Navigation to next screen.
* Base Permissions Manager protocol, extending to:
  * Push Notifications
  * Location
* Configured type-safe assets via `R.swift`.
* Commonly used extensions, constants, and utility functions.

## Using the template
To migrate this template to your own project:
* Clone this repository.
* Rename the project by following these steps from [StackOverflow](https://stackoverflow.com/a/35500038).

### Env-specific values
This codebase is already configured with three environments - `Dev`, `QA`, and `Release`, all with their corresponding schemes of the same name. 

The env-specific variables are declared in the `Build Settings` under `User-Defined`. These are keys that starts with `UD_` to specifically distinguish it with its other settings. Some of its values are dependent with the others, for example, `UD_APP_NAME` is declared as `$(UD_BASE_APP_NAME)$(UD_APP_SUFFIX)`. Update the values accordingly to your project's needs.

For sensitive values (access tokens, etc.), you may want to implement the approach of copying an environment's corresponding `.plist` file on runtine.

To access these user-defined settings in the app:
* Declare the keys and values in your `Info.plist` file.
* In `Bundle` extension, you will see some variable declared for retrieving said values from `Info.plist`.
* Add/Update accordingly.

## How to use the codebase
### UserDefaults
This is where lightweight data will be stored (e.g. tokens, user profile, etc.). An extension is already available to fetch, set, and remove data based on a type-safe key, defined under `Keys`.

### Endpoint
`Endpoint` struct is available to declare various endpoints to be used across the app. There are already samples provided for reference. 

Also under `url`, update `basePath` accordingly.

### Codables
This is where you will declare all codable structs related to API requests and responses. A base codable is already provided for reference.

#### APIResponseDecodable
Protocol declared for the base API response shared across all endpoints. Conform structs to be added to this protocol (see `BaseAPIResponse`).

#### LoginRequest
Codable used to pass the body payload to the login endpoint. A static variable has already been provided to be used for testing purposes, as seen in `LoginViewController`.

### Managers
`CapabilityManager` protocol is for implementing permission managers (e.g. Push Notifications, Locations). Use `configure()` to setup the managers, while `requestAuthorization` is to prompt the request to user. 

For denied requests, the managers can present a dialog to allow them to change these settings. These permissions are defined in `PermissionType`.

### R.swift
[R.swift](https://github.com/mac-cain13/R.swift) allows various assets (e.g. UIStoryboard, UIColor) to be used type-safe across the codebase. The definitions of these type are rebuilt on every app build.

### Errors
You can define custom errors via `CustomError`. There are already provided cases for network error, and message-defined errors.

### Cells
Use `ConfigurableCell` protocol for cells with data coming from codable instances.

### View Controllers and View Models
Various protocols are declared to add view model capabilities to a controller. For view models, protocols are also defined by its purpose, either for fetching data, or for form validation. See `LoginViewController` and `LoginViewModel` for a sample implementation.
