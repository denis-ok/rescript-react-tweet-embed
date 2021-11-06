module App = {
  let tweetIds = [
    "1305869118000762882",
    "1354175246312595457",
    "1347527685933850625",
    "1350425575308013568",
    "1354507737368031246",
    "1213121313952423937",
    "1109105694790291456",
    "1339987635398426625",
    "1225090098607349760",
    "1326421057222406145",
    "1085184133364469760",
    "1329723731946692608",
    "1331240527648280578",
    "1192212652111450112",
    "1189575825429061633",
    "1200974492262191110",
    "1283798198323208192",
    "1202510642592264193",
    "1288929821737676801",
    "1351499974870228993",
    "1146330605979930624",
    "1336702417518415874",
    "1203732239160414214",
    "1177202828810620928",
    "1335312236018077703",
    "1244655591882186755",
  ]

  let getRandomTweetId = () => tweetIds->Belt.Array.shuffle->Belt.Array.getUnsafe(0)

  @react.component
  let make = () => {
    let (tweetId, setTweetId) = React.useState(() => getRandomTweetId())

    <div>
      <button onClick={_ => setTweetId(_ => getRandomTweetId())}>
        {"Random tweet"->React.string}
      </button>
      <h3> {"Tweet id: "->React.string} {tweetId->React.string} </h3>
      <TweetEmbed id=tweetId />
    </div>
  }
}

switch ReactDOM.querySelector("#app") {
| Some(root) => ReactDOM.render(<App />, root)
| None => ()
}
