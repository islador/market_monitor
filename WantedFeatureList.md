# Wanted Feature List

# Prioritized List

1. User Account API Validated Authentication
2. User Profile Page
3. Market Stock Level Monitoring
4. Market Velocity Calculating
5. Contract Monitoring
6. Item in Transit Monitoring


## Full List
1. User Account API Validated Authentication
  * Demands the EVE API to register an account.
  * Matches tool access to this.

2. Market stock level monitoring
  * Parses the market host's API for market orders.
  * Displays the host's existing stock on market for each item id.
  * Displays the host's original market stock before sales.
  * Displays and highlights orders that have sold out.
  * Each displayed order includes average purchase price, average sale price, average %markup, existing stock, order original stock
  * Handles corporation and/or charater APIs

3. Market Velocity calculating 
  * Calculates the average market velocity for each item id sold.
  * Calculates the market velocity of each item id for the last 7 days and displaying it on the market monitor page.

4. Multi-API parsing
  * Combines different character/corporation APIs into a combined stock level display

5. Market stock EFT Comparison
  * Parses an EFT fit and displays how many copies of that fit may be purchased from a market.
  * Displays a color coded list of which items run out first.
  * Takes a number and displays how many of each item used are missing to make that number of the fit.

6. Profit Calculations
  * Calculates and displays Profit by tallying up the difference in sale prices for all items sold.
  * Calculates and displays Profit per item id over the last 7 days, 28 days and lifetime.

7. Purchaser Monitoring
  * Logs the item id, quantity and buyer of all sales.
  * Generates reports on each buyer.
    * Reports contain the user's name, affiliations and buying history.

8. Stock level alerts
  * Calculates how long until an order sells out at current and average market velocity.
  * Displays a timer for the duration next to each market order on the stock level monitoring page.

9. Market History Metrics
  * Calculates and displays the total quantity of items sold during the last 7 days, 28 days and lifetime.
  * Calculates and displays the total quantity of items sold during the last 7 days, 28 days and lifetime for each purchaser.

10. Specialty Alerts
  * Uses the bulksms RESTful API to send an emergency message to the market manager's registered phone #.
  * Alerts include bulk sales with configurable thresholds.

11. Item in Transit Monitoring
  * Use the transaction & asset APIs to track which stage a market order is in.
    * Stages: Purchased, Shipping-HighSec, Shipping-NullSec, On Market, Sold Out
      * Use state machines.

12. Contract Monitoring
  * Use the contracts APIs to monitor existing contracts.
  * Parses EFT Fits and allow for those fits to be saved and labeled as contract templates.
  * Display current contracts in the following manner
  	* Each Contract Class is displayed as a row in a table, classes are based on templates. If a contract's items
  	  include all the items in a template, it is part of that class.
  	* Each row contains the average: total_purchase_price, sale price, % markup.
  	* Each row contains the total number of active contracts in the class, the number of
  	  failed contracts in the class, the soonest contract expiration date and the latest 
  	  contract expiration date.
  	* Each row contains an editable alert threshold
  	  * When the number of contracts in a class falls below the threshold, the row turns red.
  	* Rows are ordered alphabetically by default but may be ordered in the browser by any
  	  column element.
    * Contract Classes without any active contracts are displayed at the bottom of the list.

13. User Profile Page
  * Display user account page.
  * Allows editing of all attributes except email.
  * Displays a list of which APIs are accessible to the application.