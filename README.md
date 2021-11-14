# rescript-react-tweet-embed

### ReScript React component to embed tweets.

## Install

```
npm install rescript-react-tweet-embed
```

Add `rescript-react-tweet-embed` to your `bsconfig.json`:

```json
{
  "bs-dependencies": ["rescript-react-tweet-embed"]
}
```

## Usage

```rescript
<TweetEmbed
  id="1435927427662946317"
  theme=#dark
  onLoad={element =>
    switch element {
    | Ok(element) => Js.log2("Tweet loaded: ", element)
    | Error() => Js.log("Tweet failed to load")
    }}
/>
```

## Development

```
make start
```
