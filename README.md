# Form Example

This project is an example of a form that can be used by users to fill out a form online and submit their results by approval by administrators.
This app was build as an example for [Futures Fund](www.thefuturesfund.org) level III students.

This specific example is a form for a summer camp.

# Creating the Form scaffold

To get started, let's create a scaffold for the form.
Scaffolds give us a model, views, and controllers to get started.

Before we make the scaffold, we'll want to layout the data we'll need for our signup form:

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

This is a lot of data, so the command to generate our scaffold will be pretty verbose:

```shell
rails g scaffold Form first_name:string last_name:string email_address:string address:string city:string state:string zipcode:string gender:integer grade:integer dietary_restrictions:boolean dietary_restrictions_description:string emergency_contact_name:string emergency_contact_relationship:string emergency_contact_phone:string emergency_contact_address:string emergency_contact_city:string emergency_contact_state:string emergency_contact_zipcode:string
```

That will create a migration for us, which we'll need to run with `rails db:migrate`.

Now we should be able to fire up the app with `rails server` and see the form at `http://localhost:3000/forms/new` to see the form.

# Setting up our model

Let's get to work writing the model code.

### Setting up enums

Our database includes some [enums](http://api.rubyonrails.org/classes/ActiveRecord/Enum.html).
Let's add the code from those enums to our `Form` model at `app/models/form.rb`:

```ruby
class Form < ApplicationRecord
  enum gender: [ :male, :female, :other ]
  enum grade: [ "9th", "10th", "11th", "12th" ]
end
```

This code will allow us to map integers in the database to strings at the application level.

### Adding Validations

[Validations in Rails](http://guides.rubyonrails.org/active_record_validations.html) allow us to verify that data is valid before we save it.
We won't go into too much detail about what each validation means.
You can research that on your own.
Here's what we'll need to add to our `Form` model to get the validations we need:

```ruby
validates :first_name, presence: true
validates :last_name, presence: true
validates :email_address, presence: true, format: { with: /\A\S+@\S+\z/ }
validates :address, presence: true
validates :city, presence: true
validates :state, presence: true
validates :zipcode, presence: true
validates :gender, presence: true
validates :grade, presence: true
validates :dietary_restrictions_description, presence: true, if: :dietary_restrictions?
validates :emergency_contact_name, presence: true
validates :emergency_contact_relationship, presence: true
validates :emergency_contact_phone, presence: true
validates :emergency_contact_address, presence: true
validates :emergency_contact_city, presence: true
validates :emergency_contact_state, presence: true
validates :emergency_contact_zipcode, presence: true
```

That's a lot of validations.
But now, if we go and try to submit the form with required fields blank, we should see a scary red error message.

# Setting up the our views

Now that our model code is working, let's get the views right.

### Form inputs

Let's configure some of these form inputs.
The code for the new form view lives in `app/views/forms/new.html.erb`.
That code simply includes a partial named `_form` which is at `app/views/forms/_form.html.erb`.
The form partial is where we'll be doing most of our work.

Let's start with the email input.
By default, that is a `text_field`, but we can use the browser's native email input by replacing that with an `email_field`:

```erb
<div class="field">
  <%= f.label :email_address %>
  <%= f.email_field :email_address %>
</div>
```

Next, let's look at the gender and grade inputs.
Right now those are text fields as well which is not fun since there's no way of knowing what you should type there.
We can choose to do something radio buttons or a dropdown here.
I'm going to go with radio buttons for the genders, and a dropdown for grades.

```erb
<!-- Gender -->
<div class="field">
  <%= f.label :gender %>

  <%= f.label :gender, "Male", value:  "male" %>
  <%= f.radio_button :gender, "male" %>
  <%= f.label :gender, "Female", value:  "female" %>
  <%= f.radio_button :gender, "female" %>
  <%= f.label :gender, "Other", value:  "other" %>
  <%= f.radio_button :gender, "other" %>
</div>
```

```erb
<!-- Grade -->
<div class="field">
  <%= f.label :grade %>
  <%= f.select :grade, Form.grades.keys.to_a %>
</div>
```

Now let's look at the dietary restrictions.
Currently, that is a text field.
It may make more sense for us to change it to a text area:

```erb
<div class="field">
  <%= f.label :dietary_restrictions_description %>
  <%= f.text_area :dietary_restrictions_description %>
</div>
```

Finally, let's look some more at the dietary restrictions descriptions.
It's label does not make much sense to me, a person who has no idea what they're doing.
Luckily, we can change it by sticking a string in there:

```erb
<%= f.label :dietary_restrictions_description, "Please describe any dietary restrictions that may be present" %>
```

It's truly incredible what kids can do with computers there days.

### Styles

As it stands, our form is ugly.
We don't want an ugly form, so we're going to add some styles.
Let's start by deleting everything in `app/assets/stylesheets/scaffolds.scss`.
Deleting the styles there will get us back to bare bones HTML elements.

I'm adding styles to files in `app/assets/stylesheets/`.
I won't go into detail about what's going on in there b/c it's out of scope for this example.
But, you can check it out.

