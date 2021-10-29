module App = {
  @react.component
  let make = () => {
    <div> <EmbedTweet /> </div>
  }
}

switch ReactDOM.querySelector("#app") {
| Some(root) => ReactDOM.render(<App />, root)
| None => ()
}
