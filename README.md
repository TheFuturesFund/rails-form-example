# Form Example

This project is an example of a form that can be used by users to fill out a form online and submit their results by approval by administrators.
This app was build as an example for [Futures Fund](www.thefuturesfund.org) level III students.

This specific example is a form for a summer camp.

# Creating the Form scaffold

To get started, let's create a scaffold for the form.
Scaffolds give us a model, views, and controllers to get started.

Before we make the scaffold, we'll want to layout the data we're inserting:

| Name                             | Type    |
|----------------------------------|---------|
| first_name                       | string  |
| last_name                        | string  |
| email_address                    | string  |
| address                          | string  |
| city                             | string  |
| state                            | string  |
| zipcode                          | string  |
| gender                           | enum    |
| grade                            | enum    |
| dietary_restrictions             | boolean |
| dietary_restrictions_description | text    |
| emergency_contact_name           | string  |
| emergency_contact_relationship   | string  |
| emergency_contact_phone          | string  |
| emergency_contact_address        | string  |
| emergency_contact_city           | string  |
| emergency_contact_state          | string  |
| emergenct_contact_zipcode        | string  |
