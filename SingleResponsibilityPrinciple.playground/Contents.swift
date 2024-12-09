import Foundation


// Single Responsibility Principle

struct User {
    let username: String
    let displayName: String
}

struct Tweet {
    let favoriteCount: Int
    let retweetCount: Int
    let body: String
    let user: User
}

struct UserViewModel: CustomStringConvertible {
    private let user: User
    
    init (user: User) {
        self.user = user
    }
    
    var description: String {
        "\(user.username) • \(user.displayName)"
    }
}

struct TweetViewModel: CustomStringConvertible {
    private let tweet: Tweet
    private let userViewModel: UserViewModel
    
    init (tweet: Tweet, userViewModel: UserViewModel) {
        self.tweet = tweet
        self.userViewModel = userViewModel
    }
    
    var description: String {
        """
        \(userViewModel)
        \(body)
        \(tweetMetrics)
        """
    }
    
    private var body: String {
        tweet.body
    }
    
    private var tweetMetrics: String {
        favorites + " • " + retweets
    }
    
    private var favorites: String {
        pluralize(term: "favorite", tweet.favoriteCount)
    }
    
    private var retweets: String {
        pluralize(term: "retweet", tweet.retweetCount)
    }
    
    private func pluralize (term: String, _ count: Int) -> String {
        return "\(count) " + term.capitalized + (count == 1 ? "" : "s")
    }
}


let user = User(username: "@johndoe", displayName: "John Doe")
let userViewModel = UserViewModel(user: user)

let tweet = Tweet(favoriteCount: 1, retweetCount: 20, body: "This is a tweet about something", user: user)
let tweetViewModel = TweetViewModel(tweet: tweet, userViewModel: userViewModel)


print(tweetViewModel)
