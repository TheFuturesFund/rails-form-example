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
We can choose to do radio buttons or a dropdown here.
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

### Index and show views

Now, let's clean up the views in `app/views/forms/index.html.erb`.
This is the view that shows the list of all forms.
Again, I won't go into too much detail about what is going on there.
You can look at those files to see the end result.

# Setting up the routes

Right now, everything still lives at `localhost:3000/forms`.
Let's get our routes in order so things make sense.

In `config/routes.rb`, lets find `resource :form` and replace it with:

```ruby
resources :forms, only: [:new, :create, :index, :show, :destroy]
root to: "forms#new"
```

This will gives us routes for just the actions we need, and also setup the root route to be the new form.

# Adding Auth

We'll want to require people to sign in to see the complete forms.
For that we'll use [Devise](https://github.com/plataformatec/devise).
Devise has [its own instructions to get started](https://github.com/plataformatec/devise#getting-started).
Follow those until it's time to generate our model.

### Adding an Admin model

When it's time to generate models.
We'll generate one named `Admin`.

```shell
rails generate devise Admin
```

Again, we'll need to run `rails db:migrate` to apply our changes to the database.

Now there's a few new routes we can try out:

- http://localhost:3000/admins/sign_in
- http://localhost:3000/admins/sign_up

Since it doesn't make sense for people to be able to sign up to be an admin, let's drop that functionality.
Go to the `Admin` model at `app/models/admin.rb`.
In the list of Devise models, let's remove `:registerable`.

```ruby
class Admin < ApplicationRecord
  devise :database_authenticatable,
    :recoverable,
    :rememberable,
    :trackable,
    :validatable
end
```

Now the sign up route should no longer work.

### Add auth to views

Let's make our views aware of whose signed in.
In the application layout (`app/views/layouts/application.html.erb`) let's add the following to our `<body>` tag:

```erb
<body>
  <% if admin_signed_in? %>
    <p>
      Sign in as <%= current_admin.email %>.
      <%= link_to "Sign out", destroy_admin_session_path, method: :delete %>.
    </p>
  <% else %>
    <p>
      <%= link_to "Admin sign in", new_admin_session_path %>
    </p>
  <% end %>
  <%= yield %>
</body>
```

Now all of our views should have links to sign in or sign out depending on whether we're sign in.

### Adding test users

We've removed sign up, so how do we add users to test sign in?
We can do so using the [Rails console](http://guides.rubyonrails.org/command_line.html).
To start the console, run `rails console` in your terminal.

One the console start up, we can use it to create users:

```ruby
irb(main):001:0> Admin.create(
irb(main):002:1* email: "admin@example.com",
irb(main):003:1* password: "password",
irb(main):004:1* )
```

Now we should be able to go back to our browser and log in with the email `admin@example.com` and the password `password`.
Run `quit` on the console to leave the Rails console.

### Protecting our views

We have accounts, but you can still see the submissions w/o signing in.
Let's fix that by going to our Forms controller at `app/controllers/forms_controller.rb`.
There we'll add a before filter to make sure only authenticated users can use our form.

```ruby
class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:new, :create]

  # ...
end
```

Now, if we try to look at the list of submissions at `/forms`, we're kicked back to the login screen.
The logic above tells the controller to this for each of its actions except the new action and create action.

This is looking pretty good, but now there's some weird behavior.
After submitting a form, you're redirected to the login screen with a message telling you to sign in to continue.
This is happening because after submitting our form, we're redirected to the show view for our form which is now protected by Devise.
Let's instead add a new view to redirect to saying the form is complete.

First, let's add a new view at `app/views/forms/submitted.html.erb`:

```
<h1>Submitted successfully</h1>

<p>
  <em>Your application has been submitted and is being processed!</em>
</p>

<p>
  Do you have another child interested in joining us this summer?
  Submit another application <%= link_to "here", new_form_path %>.
</p>
```

Now, let's add a controller action for this view.
Since the view doesn't have any logic, our controller action doesn't need to do anything, so the function can be empty.
In `app/controllers/forms_controller.rb`, let's add the following between the `show` and `new` actions:

```ruby
  def show
  end

  def submitted
  end

  def new
    @form = Form.new
  end
```

Let's wire that action up to a path in `config/routes`.
To do this, we'll add a block to our form resources declaration:

```ruby
Rails.application.routes.draw do
  devise_for :admins
  resources :forms, only: [:new,  :create, :index, :show, :destroy] do
    get "submitted", on: :collection
  end
  root to: "forms#new"
end
```

We'll have the app redirect to that URL after successful form submission.
Change the `create` action in the forms controller at `app/controllers/forms_controller.rb`:

```ruby
def create
  @form = Form.new(form_params)

  respond_to do |format|
    if @form.save
      # The next line is the one that changes
      format.html { redirect_to submitted_forms_path, notice: 'Form was successfully created.' }
      format.json { render :show, status: :created, location: @form }
    else
      format.html { render :new }
      format.json { render json: @form.errors, status: :unprocessable_entity }
    end
  end
end
```

Finally, let's change the authentication before filter in the forms controller to except the `submitted` action:

```ruby
class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:new, :create, :submitted]

  # ...
end
```
