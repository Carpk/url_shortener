url_shortener
=============

1
Sinatra URL Shortener Challenge

Objectives
Comments
Your Attempts
Recent Attempts
We're going to build a simple link shortener, a la bitly.

You'll have one model Url, which is a list of URLs that people have entered.

Learning Goals
Deepen your understanding of HTTP redirects.
Explore ActiveRecord callbacks.
Objectives
Simple Shortener
Start with this empty Sinatra skeleton.

We have one resource: Urls. For our controllers, we have a URL that lists all our Url objects and another URL that, when POSTed to, creates a Url object.

We'll also need a URL that redirects us to the full (unshortened) URL. If you've never used bitly, use it now to get a feel for how it works.

The controller methods should look like this:

get '/' do
  # let user create new short URL, display a list of shortened URLs
end

post '/urls' do
  # create a new Url
end

# e.g., /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
end
Use a before_save callback in the Url model to generate the short URL.

Counter!
Add a click_count field to your urls table, which keeps track of how many times someone has visited the shortened URL. Add code to the appropriate place in your controller code so that any time someone hits a short URL the counter for the appropriate Url is incremented by 1.

Add Validations
Add a validation to your Url model so that only Urls with valid URLs get saved to the database. Read up on ActiveRecord validations.

What constitutes a "valid URL" is up to you. It's a sliding scale, from validations that would permit lots of invalid URLs to validations that might reject lots of valid URLs. When you get into it you'll see that expressing the fact "x is a valid URL" in Ruby Land or SQL Land is never perfect.

For example, the valid URL could range across:

A valid URL is...

Any non-empty string
Any non-empty string that starts with "http://" or "https://"
Any string that the Ruby URI module says is valid
Any URL-looking thing which responds to a HTTP request, i.e., we actually check to see if the URL is accessible via HTTP
Some of these are easily expressible in SQL Land. Some of these are hard to express in SQL Land, but ActiveRecord comes with pre-built validation helpers that make it easy to express in Ruby Land. Others require custom validations that express logic unique to our application domain.

The rule of thumb is that where we can, we want to always express constraints in Ruby Land and also express them in SQL Land where feasible.

Add Error Handling
When you try to save (create or update) an ActiveRecord object that has invalid data, ActiveRecord will fail. Some methods like create! and save! throw an exception. Others like create (without the ! bang) return the resulting object whether the object was saved successfully to the database or not, while save will return false if perform_validation is true and any validations fail. See create and save for more information.

You can always call valid? or invalid? on an ActiveRecord object to see whether its data is valid or invalid.

Use this and the errors method to display a helpful error message if a user enters an invalid URL, giving them the opportunity to correct their error.

More on Validations, Constraints, and Database Consistency
We often want to put constraints on what sort of data can go into our database. This way we can guarantee that all data in the database conforms to certain standards, e.g., there are no users missing an email address. Guarantees of this kind — ensuring that the data in our database is never confusing or contradictory or partially changed or otherwise invalid — are called consistency.

If we think of this as a fact from Fact Land, these constraints look like:

A user must have a first_name
A user must have an email
Two user's can't have the same email address, or equivalently, each user's email must be unique
A Craigslist post's URL must be a valid URL, for some reasonable definition of valid
These facts can be recorded in both SQL Land and in Ruby Land, like this:

Fact Land	SQL Land	Ruby Land
A user must have an email address	NOT NULL constraint on email field	validates :email, :presence => true
A user must have a first name	NOT NULL constraint on first_name field	validates :first_name, :presence => true
A user's email address must be unique	UNIQUE INDEX on email field	validates :email, :uniqueness => true
