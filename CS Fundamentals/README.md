
# Example CS Fundamentals Question & Answer

Here's an example question and answer for a CS fundamentals interview question.

### “Given a string, find if it’s open and close parentheses are balanced.”

Getting the answer right is about 10-20% of your mark here, it’s all in your thought process and the path you take to get there!

### 1. Ask Clarifying Questions

#### Strategy
1.  Repeat the problem to yourself out loud.
2.  State your assumptions, if you have any.
3.  If you feel like something is unclear or ambiguous, ask questions.
4.  Once everything is clear, repeat the problem back to the interviewer, in your words.
5.  Ask them if your interpretation is correct.
6.  Rinse and repeat, as needed.

#### Example
1) When you say parentheses, do you just mean parentheses;  `"("`  and  `")"`, or does that include curly braces;  `"{"`  and  `"}"`  and brackets  `"["`  and  `"]"`?

	  **Answer:**  All three of them.

2)  What do you mean by balanced? Is it simply that there has to be an equal amount of left and right parentheses?

	**Answer**:  Each opening parenthesis has to have a closing pair and each pair is properly nested.

3) Are there any helpers or framework extensions I shouldn’t use?

	**Answer:**  Not that I can think of.

4)  Does my code need to compile, or is it OK if I write pseudo code?
	
	**Answer:**  Your code should compile.

5)  Do you have any test input examples?
	
	**Answer:** Yes,  `"([]){({})}"`  should be true, and  `"{}([[{]])}"`  should be false. You can, of course, use other examples to test.
	
### 2. Talk Aloud

#### Strategy
When you have a good grasp on the problem, start thinking about how to solve it. Take a little breath to consolidate your thoughts in silence, and then start sharing them with the interviewer. It’s essential that they understand your thought process so they can get a glimpse in how you work, and also help you along the way if you get stuck. Engage them and regularly ask for their opinion at decision points!

#### Example
Here’s what I’m thinking. Initially I thought I could just keep a counter per pair of parenthesis, so three counters in total. I would traverse the String one-by-one and every time I’d see an opening one, I’d increase it by 1. Every time I’d see a matching closing one, I’d decrease it by 1. That way, if they were all at 0 at the end, the parenthesis would be balanced.

But, since you mentioned that they have to match, meaning that an open parenthesis has to be followed by a closing one of the same pair, the problem is slightly different. So, now I think that this sounds like a perfect problem for using stacks as a data structure. How does that sound? 

**Answer:**  Sounds like a good start.

Stacks are a first in, last out (FILO) data structure, so my plan is that every time I see an open parenthesis, I pop it on the stack. If I find a closing parenthesis, I check if it matches the last opening one. If it matches, we pop the last item, the open parenthesis, off the stack. When we come to the end of the String, we should have no elements left, otherwise, the String is not balanced. Does that seem like a good way to proceed? 

**Answer:**  Yep, go ahead.

### 3. Propose and Discuss Solution
Once you feel like you know what you need to know, and the interviewer has given you their go-ahead on your direction, start laying out the solution.

#### Example

Now, Stacks don’t exist in Swift, so would you like me to implement a  `Stack`  data structure? (_Answer:_  Yes.)

Ok, so I think I want to create the  `Stack`  as a struct backed by an array. I’ll implement the necessary functions for popping, pushing and peeking. I’ll write some pseudo code to start with. 

**Answer:**  Sounds like a good start.

	struct Stack<T> {
		private var array: [T] = []
	
		// Remove an element from the stack and return it 
		func pop() -> T? {}
		
		// Add element to stack
		func push(element: T) {}
	
		// Look at what element is at the top
		func peek() -> T? {}
	}

Then I think I need to know how the open and closing parentheses characters match. I’m thinking of creating an extension on the `Character` class. It would check whether the `Character` is `"("`, `"{"` or `"["` and return their closing parentheses.

**Answer:**  Yep, go ahead.

	extension Character {
		func isMatchingPair(closing: Character) -> Bool {}
	}

Finally, I think I’m going to create another extension, this time on the `String` class that will tell me if the `String` has balanced parentheses.

	extension String {
		var hasBalancedParentheses: Bool {}
	}

### 4. Write and Test Code

Now that you have the structure of what you want to build, it’s time to translate what you described previously into code. Continue speaking out loud as you write out the code. Once you’re happy with the outcome, go through the test cases you were given to check if your algorithm check out. Try out a couple of edge cases as well, to show that you’re thinking beyond what you were given and fix your code before ultimately putting it up for tribute!

	struct Stack<T> {
		private var array: [T] = []
		
		@discardableResult mutating func pop() -> T? {
			array.popLast()
		}
		
		mutating func push(element: T) {
			array.append(element)
		}
		
		func peek() -> T? {
			return array.last
		}
		
		var isEmpty: Bool {
			return array.isEmpty
		}
	}
	
	extension Character {
		func isMatchingPair(closing: Character) -> Bool {
			switch self {
			case "(":
				return closing == ")"
			case "[":
				return closing == "]"
			case "{":
				return closing == "}"
			default:
				return false
			}
		}
	}
	
	extension String {
		var openingParentheses: [String] {
			return ["(", "[", "{"]
		}
		
		var closingParentheses: [String] {
			return [")", "}", "]"]
		}
		
		var hasBalancedParentheses: Bool {
			var parentheses: Stack<Character> = Stack()
			
			for char in self {
				
				if parentheses.isEmpty {
					if openingParentheses.contains("\(char)") {
						parentheses.push(element: char)
					} else if closingParentheses.contains("\(char)") {
						return false
					}
				} else {
					if let top = parentheses.peek() {
						if top.isMatchingPair(closing: char) {
							parentheses.pop()
						} else if openingParentheses.contains("\(char)") {
							parentheses.push(element: char)
						}
					}
				}
			}
			return parentheses.isEmpty
		}
	}

### 5. Optimize and Improve

Once everything checks out, and your interviewer is pleased with the result, it’s likely you’ll be asked about the time and space complexity of your code. This means you’ll have to do a Big-O analysis of the main functionality you’ve just written, in this case it would be the  `hasBalancedParentheses` computed property.

Because we’re only looping through our dataset once, the Big-O here is O(n), the complexity for both space and time is linear.

It’s also possible that they’ll ask you to optimize your code if the analysis reveals that the complexity is O(n^2) for example. In our case, this is as optimal as we can get!

### 6. Additional Tips

Here are a few additional tips for performing well in these types of interviews:

-   Use clear names for variables and functions.
-   If you know you won’t have enough time to actually write everything out, stop. Don’t try to rush. Instead, take the interviewer through the steps you would have taken, if you had more time.
-   Don’t get distracted if your interviewer isn’t showing any emotions. They’re supposed to look nonplussed to not sway you in any way.
-   Ask if they want your code to compile at the end. When writing pseudo code, we don’t necessarily adhere to the syntactic rules of the language, even though the interviewer might be expecting it.

## Questions
If you have any questions, comments or concerns, open a Github Issue on this repository.
