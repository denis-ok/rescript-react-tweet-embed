@val external document: {..} = "document"

@val external window: {..} = "window"

module TwitterApi = {
  type t

  type widgets

  external get: (t, string) => option<string> = "get"

  @get
  external widgets: t => widgets = "widgets"

  @send
  external createTweet: (widgets, string, Dom.element, 'a) => unit = "createTweet"

  module Parameters = {
    // https://developer.twitter.com/en/docs/twitter-for-websites/embedded-tweets/guides/embedded-tweet-parameter-reference
    type theme = [#dark | #light]

    type t = {theme: theme}

    let make = (~theme): t => {
      theme: theme,
    }
  }

  let createTweet = (t: t, id, element, parameters: Parameters.t) =>
    t->widgets->createTweet(id, element, parameters)
}

type twitterScriptStatus = NotAdded | Loading | Loaded(TwitterApi.t)

let twitterScriptStatus = ref(NotAdded)

let callbacks: ref<list<unit => unit>> = ref(list{})

let addScript = () => {
  let script = document["createElement"](. "script")
  let () = script["setAttribute"](. "src", "//platform.twitter.com/widgets.js")
  let () = script["onload"] = () => {
    switch (window["twttr"]: option<TwitterApi.t>) {
    | Some(api) =>
      twitterScriptStatus := Loaded(api)
      callbacks.contents->Belt.List.forEach(callback => callback())
      callbacks := list{}
    | None =>
      Js.Console.error(
        "[rescript-react-embed-tweet] unexpected state: twitter script is loaded, but window.twttr is undefined",
      )
    }
  }
  let () = document["body"]["appendChild"](. script)
}

let useTwitterApi = () => {
  let (twitterApi, setTwitterApi) = React.useState(() => None)

  React.useEffect0(() => {
    switch twitterScriptStatus.contents {
    | NotAdded =>
      twitterScriptStatus := Loading
      callbacks := list{() => setTwitterApi(_ => window["twttr"]), ...callbacks.contents}
      addScript()
    | Loading => callbacks := list{() => setTwitterApi(_ => window["twttr"]), ...callbacks.contents}
    | Loaded(t) => setTwitterApi(_ => Some(t))
    }
    None
  })

  twitterApi
}

@react.component
let make = (
  ~className: option<string>=?,
  ~id: string,
  ~style: option<ReactDOM.style>=?,
  ~theme: TwitterApi.Parameters.theme=#light,
) => {
  let twitterApi = useTwitterApi()

  let divRef: React.ref<Js.Nullable.t<Dom.element>> = React.useRef(Js.Nullable.null)

  React.useEffect2(() => {
    switch (twitterApi, divRef.current->Js.Nullable.toOption) {
    | (Some(twitterApi), Some(element)) =>
      TwitterApi.createTweet(twitterApi, id, element, TwitterApi.Parameters.make(~theme))
    | _ => ()
    }
    None
  }, (twitterApi, id))

  <div ?className ?style key=id ref={ReactDOM.Ref.domRef(divRef)} />
}
