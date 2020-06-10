Questions
================================== 

These are all the questions we've gathered from the iOS community. Some have comments as to why the question is asked, or hints for the answer. Enjoy! And if you want a question included here, please submit a PR!

<iframe class="airtable-embed" src="https://airtable.com/embed/shrikTPjGlPxeUT4S?backgroundColor=yellow&viewControls=on" frameborder="0" onmousewheel="" width="100%" height="533" style="background: transparent; border: 1px solid #ccc;"></iframe>

### Design Patterns
What is MVC?

What are some MVC alternatives? Discuss tradeoffs, benefits, negatives.

How would you approach changing a design pattern from MVC to MVVM?

What's a bad design pattern?

List 3 different Design Patterns that you know?

How would you design a system for uploading images in iOS? From backend, database, handling different cases...

### CS Fundamentals

Implement the LRU cache.

> This is a must to have under your belt. Having just gone through the
> coding interviews, this is often asked and without some of the
> LinkedLists Java has, knowing how to do it in swift is crucial.

Given an array of integer and a sum, return, if possible the indices of the two integers that add up to that sum.

> This question is common because it can be built upon by advancing to
> 3sum and is often asked.

Given a string, find if it's open and close parentheses are balanced.

> A bit abstract, but good question to learn about usage of stacks and
> how to analyze a problem.

Given a binary tree, print it out in a column-based fashion.

> A bit of algorithmic and away from real life examples, but solving it
> and data structures to use have been a great practice.

What is the copy-on-write rule?

List and discuss 3 different Object Oriented Programming concepts?

Differences, use cases, benefits, negatives.

### Community Engagement

Who are your favourite iOS/Swift podcasters/authors/video creators, and why?

> I find this to be a great way to gauge someones engagement with the
> platform and community. It's harder than you think to recall names in
> an interview, so being quick with names is a big plus. Also it's a
> great way to start conversations about areas of interest in the
> platform they may have. The deeper their engagement, the stronger
> their passion for the platform and the better support network they'll
> have and can share at work.

Tell me about one of your pet projects?

How do you approach convincing your team to use a new technology (Storyboards vs programmatic UI, MVVM vs MVC)? 

Have you contributed to any open source project in the last year?

> This question helps me see if the interviewee has both a collective
> and an open mindset. Working for open source projects enforces certain rules and guidelines (even more for serious projects with thousands of stars), so when I ask this question, I'm mainly looking for the teamwork experience with unknown people whom may have completely different work ethics and availabilities. I'm not looking for a top contributor, even a single bug fix or a slight change in documentation can be a good indicator about the capacity of understanding contribution rules. It also shows the problem fixing capacity of the interviewee, if he or she is capable of creating or helping an OSS project just to tackle a specific issue, it means that he or she is capable of overcoming the fear of being judged on the code you're producing (it can also be used to review some code before performing a technical test). Knowledge of public CIs systems and code coverage websites is a big plus.

What did you find the most exciting at the last WWDC?
> Answers like "everything" or "I don't watch it" or "What's that" are
> red flags for me. From their answer, it's easy to start a discussion.

### iOS Specific

Explain different kinds of dependency injection.

Explain enums in Swift.
Explain generics in Swift.

> Shows a strong knowledge of the swift language and most industry code bases leverage these.

The `final` modifier applied to a class declaration makes the class final. 

> What are the benefits of marking a class `final`? A non-final class
> can be subclassed, and its methods can be overridden. So given a
> method of a class, that method can have different implementations in
> any of the subclasses. When a method is invoked, the runtime must
> figure out which override to call, and, as such, method invocation is
> resolved dynamically, at runtime, using a vtable. If a class is
> declared final, it cannot be subclassed, and, as such, its methods
> cannot be overridden. This means that method invocations can be
> resolved statically, at compilation time. So invoking a method on a
> final class is much faster than on a non-final, subclassable class.

Is a closure a value or a reference type?

Explain the difference between classes and structs.

> I like this question because most people know at least a surface-level
> answer, but depending on their knowledge and ability to explain things
> they can get much more in-depth. In that sense, it's a good question
> to quickly judge where someone is at, whether they know things because
> they truly understand the inner workings, or are repeating things
> they've read online.

What does static mean?

Why do you like swift and what advantages or disadvantages does it have over other languages?

What is the difference between weak and unowned and when we should use which?

What is the concept of an abstract class in Swift?

Do you prefer Objective C or Swift? Why?

Which part(s) of a framework have you explored that others have not?

When would you use unowned VS weak self in a closure?

> https://stackoverflow.com/questions/24320347/shall-we-always-use-unowned-self-inside-closure-in-swift

What is Core Data?

How many possible states can a UIKit app be in and what are they?

Why do you have to update the UI on the main thread?

> It shows how deep the developer goes to discover the "why" of the
> things, and he/she doesn't only read answers on StackOverflow.

Tell me about techniques for building UI for all device types and screen sizes. 

> I can find out what the interviewee knows about Storyboards, traits
> and constraints-in-code and their relative advantages and pitfalls.I
> can find out what the interviewee knows about Storyboards, traits and
> constraints-in-code and their relative advantages and pitfalls.

What's your opinion on using Storyboards versus programmatic UI?

What's Autolayout?

What are memory leaks and how we should avoid them?

> 1) Talking a little bit about ARC and how it works.
> 
> 2) Stating the 3 main reasons for causing memory leaks which are: a)
> Strong relationship between 2 classes referencing each others b)
> Strong relationship between a protocol and a class (example in
> delegation pattern) c) Strong self inside a closure in a class.
>
> 3) To avoid them we should use weak or unowned in those cases."

How would you describe how an iOS application works to a five year old?

Explain ARC to a five year old.

How can you persist data in iOS?

What happen when I set the target of a UIControl to nil?

Tell me about NSPredicate.

What's the difference between nonatomic, atomic and copy?

What's the difference between strong, weak and unowned? 

> The difference between unowned and weak is that weak is declared as an Optional while unowned is not. By declaring it weak you get to handle the case that it might be nil inside the closure at some point. If you try to access an unowned variable that happens to be nil, it will crash the whole program. So only use unowned when you are positive that variable will always be around while the closure is around.
> 
> An example for unowned is that a credit card will always be associated
> with a customer.
> 
> https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html

What is ARC?

> Weak references don't  count in the reference count of an object.
> Unowned references also don't increase the object's reference count.
> Unowned reference have to have a value, but weak ones can be nil.

What are closures?

> https://docs.swift.org/swift-book/LanguageGuide/Closures.html

What is delegation and how does it work?

> http://www.andrewcbancroft.com/2015/03/26/what-is-delegation-a-swift-developers-guide/
> 
> https://www.andrewcbancroft.com/2015/04/08/how-delegation-works-a-swift-developer-guide/
> 
> It’s also worth noting the scope of the communication that delegation
> is intended to be used for. Whereas NSNotificationCenter fits the need
> for one instance to broadcast a message intended for more than one
> listening instance, delegation fits the scenario where an instance
> only needs to send a message to a single listener (the delegate).

Describe the iOS application 

> https://developer.apple.com/documentation/uikit

What is protocol oriented programming and what are the pros/cons of using it over OOP?

Can you explain the responder chain?

Blocks or NSOperation?

Explain memory management in iOS. is it compile time or run time?

> Gives insight about the retain cycles, leaks and memory management.

Explain the different ways of passing data in iOS.

What are singletons and what's a good use case for them in iOS applications?

Are arrays value types or reference types in swift?

What's the different between atomic and nonatomic?

### General

How do you characterize the relationship between product management and engineering?

> I want to learn about the candidate's experience working on teams, and
> get a sense for their ability to manage interpersonal communication
> and conflict. The gold standard answer is each side of this
> relationship represents a constituency with respect to an application
> (product representing the users and possibly the business, engineering
> the code and technology). Each side must vigorously advocate for their
> constituents' needs, but like in all good relationships, neither side
> may dominate. Instead, from the adversarial process arises the most
> efficient compromise between tech and product.

How do you design Gmail, FB, Note, and similar questions focused on iOS part, like which components client use, data storage, and what questions to ask.

> The design question helps to learn how to architect an app in a higher
> level and the trade-offs to it. It's a great way to think about
> scaling an app and doesn't require in-depth knowledge of technologies,
> but knowing what capabilities are there.

How do you learn about a new framework?

What Apple frameworks have you used and what for?

What was the hardest bug you've solved? Describe it.

What's a feature you're most proud of working on?

When you are starting a new longterm project from scratch, what sort of things (e.g frameworks/tools) do you think are good to add to the baseline project? Why do you add them?

> The question shows what a developer thinks are important to the
> longevity and "cleanliness" of a long-lived project. 
> Some examples are:
> - Setting up a package manager ( Cocoapods / Carthage / SPM  ) 
> - Adding a linter (e.g SwiftLint) 
> - Adding a formatter (e.g SwiftFormat) 
> - Configuring for test and adding testing packages ( Quick/Nimble )

What 3rd party frameworks do you know, like and use?

How would you evaluate the decision between using a 3rd party framework vs rolling your own solution?

Talk me through your process of deciding to build something bespoke or use a 3rd party library for a feature.

Explain continuous integration. How have you implemented it in the past?

What is code coverage? 

We have a codebase written in Objective-C. We would like to port it to Swift, but don't want to break features over time. What is your process?

### Project Based

Given this mockup, draw and take me through the constraints and UI elements you might use.

Create a one-page app to show a list of products and their price from a json hosted either online or locally. 

> The json had an image url of a product, name, and price. For extra
> points create a way to sort the list by price or item name.

Create a social media app from a json hosted online. The json had 4 endpoints, users, posts, photos, and albums. 

> Users contained a lot of user information, like their name, company,
> address, avatar image, etc. Posts had user ids and their comments.
> Albums had their names and ids, and Photos had albums ids and picture
> images. They wanted the ability to see homescreen of comments with
> users’ names and avatar, and when clicked on user name a user profile
> screen would show with user’s information.

## Any Questions
If you have any questions, comments or concerns, open a Github Issue on this repository.
