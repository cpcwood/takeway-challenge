# Takeaway Challenge
--------
```
                            _________
              r==           |       |
           _  //            |  C.W. |   ))))
          |_)//(''''':      |       |
            //  \_____:_____.-------D     )))))
           //   | ===  |   /        \
       .:'//.   \ \=|   \ /  .:'':./    )))))
      :' // ':   \ \ ''..'--:'-.. ':
      '. '' .'    \:.....:--'.-'' .'
       ':..:'                ':..:'

 ```
### Outline

Makers Academy weekend challenge to create a simple app incorporating the Twilio Gem, which allows a customer to send a food order directly or via text, and recieve a confirmation text once the order is confirmed.

### How to Install & Example

Note about setting up env files

The application is run directly from the command line, so to install simply clone or fork the repository, change directory to the root folder, open irb, and paste the following code:
```
require './lib/takeaway.rb'
```
Alternatively, run *rspec* to see the test documentation or the example script to see an overview of the program functionality.

### Customer Requirements

```
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices
```
```
As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes
```
```
As a customer
So that I can verify that my order is correct
I would like to check that the total I have been given matches the sum of the various dishes in my order
```
```
As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered
```
--------
### Approach

#### Extract Scope
- Method to provide list of dishes and corresponding prices
- Method to send order directly, hints outline order is placed by sending list of dishes, quantities, and order total, since there is no mention of input data type, this will be implemented as a string for compatibility with text input. Since instructions for ordering will be put on menu, it is assumed that the customer will not deviate from these. Also no mention of of when to input phone number, this will be included in the order
- Behaviour to check order total is correct and error if not
- Behaviour to send text confirmation to client phone number

#### Notes
- Twilo account details will be implemeneted via environment variables

#### Objects & Public Interface
Relatviely simple program so should only require one object
- Takeaway
  - #show_menu - returns menu in pretty format
  - #place_order(order) - places order accepting hash
- MenuPrinter
  - .print_menu(menu) - returns menu in fancy format

#### Create RSpec for basic object functions and implement TDD:
- Takeaway.show_menu
- MenuPrinter.print_menu
- Takeaway.place_order(order)


extra
- Method to send order via text message, order will have to be placed as SMS string, to be implemented via twilo webhook. Menu to be updated to include order by text format and number
