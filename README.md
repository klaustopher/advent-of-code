# Advent of Code

This is my code, for [Advent of Code](https://adventofcode.com/). Every folder represents one year. When I tried multiple languages, there are subfolders, but I mostly write stuff in Ruby as it is a really nice language for this. Might not be the most performant, but it usually works.

Some solutions might be solved on Stream, either on [Twitch](https://www.twitch.tv/klaustopher) or [YouTube](https://www.youtube.com/@klaustopher). But we'll see

## Party Starter

To get started quickly I have added the [Party Starter](https://github.com/klaustopher/advent-of-code/tree/master/party-starter) CLI tool. It generates code files based on [templates](https://github.com/klaustopher/advent-of-code/tree/master/templates) and text input files for the input data.

To build the CLI tool, you have to install [Crystal](https://crystal-lang.org/install/).

```
party-starter/build
```

This will put the `get-started` binary in your base folder.

```
./get-started
```

Will generate a file in `$YEAR/$LANGUAGE/$DAY.$EXT` based on the template of your language. If you want to add more languages, you cann add them in `party-starter/languages` and either change the default or use `--lang LANG` to use the template for your language.

The templates can be changed and don't need a recompile

HAPPY HACKING, from 🎅 Santa klaustopher
