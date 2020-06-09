Higher Level
================================== 

### Higher Level Topics

Here are the higher level topics you might be asked to discuss at your iOS interview.

- Dependency Injection
	- Why? 3rd parties? Testability?
- Data passing and Communication
	- Delegation, observation, KVO, notifications, singletons
- Swift & Objective C
	- Tradeoffs, positives, negatives about both
	- When to transition?
	- Interoperability
- Autolayout
	- Storyboard vs programmatic UI
	- Backend-driven UI
	- Positive, negatives of each approach
- Testing
	- UI, Unit
	- QA processes
	- TDD
- Debugging
	- Instruments, breakpoints, lldb
- Databases
	- Native? CoreData
	- 3rd Party? Realm
- Networking
	- 3rd party vs native?
	- Architecting a networking layer
- Architecture Patterns
	- MVC, MVVM, Coordinator...
	- Tradeoffs?
	- How would you decide wheat to adopt or change and plan for the refactor?
- Persist, Cache, Sync Data
	- CoreData, archiving, UserDefaults, UIDocument
	- What to cache, what not to?
- Education
	- What do you do to stay current?
	- Conferences, blogs, podcasts, books?
- Community Engagement
	- Open source, speaking, local groups
- Concurrency & Multithreading
	- Concurrent vs parallel processing
	- Semaphores
	- Dispatch groups
	- Deallocation
- Continuous Integration
	- Buddybuild, Testflight, Fastlane
- Experiments
	- A/B Testing process
	- In-house vs external tools
- Analytics
	- Tools like Mixapanel, App Annie
	- Pixel logging
- Package Managers
	- Cocoapods
	- Swift Package Manager (SPM)
	- Carthage
- 3rd Party Libraries
	- When to use them?
	- When to roll your own?
	- Which ones have you used?
	- What have you learned?
- How would you design X?
	- Replace X for some mobile application like Twitter, Gmail, Instagram...

### Questions
These are all the higher level questions we've gathered from the iOS community. Some have comments as to why the question is asked, or hints for the answer. Enjoy! And if you want a question included here, please submit a PR!

What is MVC?

What are some MVC alternatives? Discuss tradeoffs, benefits, negatives.

How would you approach changing a design pattern from MVC to MVVM?

What's a bad design pattern?

List 3 different Design Patterns that you know?

How would you design a system for uploading images in iOS? From backend, database, handling different cases...

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

Explain different kinds of dependency injection.

Why do you like swift and what advantages or disadvantages does it have over other languages?

Do you prefer Objective C or Swift? Why?

Which part(s) of a framework have you explored that others have not?

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

How can you persist data in iOS?

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

Explain memory management in iOS. is it compile time or run time?

> Gives insight about the retain cycles, leaks and memory management.

Explain the different ways of passing data in iOS.

What are singletons and what's a good use case for them in iOS applications?

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

## Any Questions
If you have any questions, comments or concerns, open a Github Issue on this repository.