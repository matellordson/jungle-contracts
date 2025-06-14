// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract Twitter {

    uint256 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint256 id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    mapping(address => Tweet[]) public tweets;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    event tweetCreated(uint256 id, address author, string content, uint256 timestamp);
    event tweetLiked(address liker, address tweetAuthur, uint256 tweekId, uint256 newLikedCount);
    event tweetUnliked(address liker, address tweetAuthur, uint256 tweekId, uint256 newLikedCount);

    modifier onlyOwner() {
        require(owner == msg.sender, "You are not the owner!");
        _;
    }

    function changeTweetLength(uint16 newTweetLeght) public onlyOwner {
        MAX_TWEET_LENGTH = newTweetLeght;
    }

    function addLikes(address author, uint256 id) external  {
        require(tweets[author][id].id == id, "Tweet does not exit!");
        tweets[author][id].likes++ ;

        emit tweetLiked(msg.sender, author, id, tweets[author][id].likes);
    }

     function removeLikes(address author, uint256 id) external  {
        require(tweets[author][id].id == id, "Tweet does not exit!");
        require(tweets[author][id].likes > 0, "There are no likes");
        tweets[author][id].likes-- ;

        emit tweetUnliked(msg.sender, author, id, tweets[author][id].likes);
    }


    function createTweet(string memory _tweet) public {

        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet too long!");

        Tweet memory newTweet = Tweet({
            id: tweets[msg.sender].length,
            author: msg.sender,
            content: _tweet,
            timestamp: block.timestamp,
            likes: 0

        });
        tweets[msg.sender].push(newTweet);

        emit tweetCreated(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    function getTweet( uint256 _index) public view returns (Tweet memory) {
        return tweets[msg.sender][_index];
    }

    function getAllTweets() public view returns (Tweet[] memory) {
        return tweets[msg.sender];
    }
}