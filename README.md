# Store

## Onboarding
## Requirements
1. Please use the last version from Xcode 13 or bigger

## API
[here](https://gist.githubusercontent.com/palcalde/6c19259bd32dd6aafa327fa557859c2f/raw/ba51779474a150ee4367cda4f4ffacdcca479887)

## Acceptance Criteria
• Shows the store with the available products.
• Add the products to the cart in different quantities.
• Move to checkout and show the receipt for the products in the cart.

## Description "PR description"
1. Remove the storyboard.
2. Build the core part of the app. "Network, Codable, Error".
3. Add the EndPoint.
4. Build the store screen with the products and allow the user to add to the cart with different quantities.
5. Allow the user to move to checkout and show the receipt.
6. Adding the unit tests

## Project Structure (MVVM)
The project with MVVM structure
- Models - for parsing the response on it
- DataSources(Remote and Local) - for fetch the data from network or database
- LayoutViewModels - for the map from models to be ready to use for the UI
- ViewModels - for handle the business logic
- ViewContoller - for the present the data into the UI controllers
- Unit tests

## Project Diagram
[Diagram](https://lucid.app/lucidchart/2f79dd1b-cd4c-4f80-b303-ab64ef619f95/edit?viewport_loc=-11%2C-11%2C2048%2C1203%2C0_0&invitationId=inv_81b6f980-83f1-41b3-903a-1530b7335265#)

## Video record for the app in run time
[Video](https://www.mediafire.com/file/fuf4x2j4k1bzx87/Simulator+Screen+Recording+-+Clone+1+of+iPhone+14+Pro+-+2023-02-08+at+11.18.01.mp4/file)

## Version
1.0
